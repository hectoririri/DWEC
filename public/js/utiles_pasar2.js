let app = new Vue({
    el: "#app", // Elemento del DOM al que hace referencia
    data: {
        url: "http://localhost/DWEC/private/ApiGrua/public/api/", // URL de la ubicación de la aplicación
        email: "", // Modelo para el campo email login
        contrasena: "", // Modelo para el campo contraseña login
        rol: "", // Rol del usuario
        usuario: "", //Json del usuario logueado
        usuario_seleccionado: "", //Json del usuario seleccionado al editar, eliminar...
        usuarios: [], // Lista usuarios

        vehiculos: [], // Lista de retiradas
        vehiculo_seleccionada: {}, // Json de el vehículo seleccionada
        formVehiculo: { // Json de campos formulario creación vehiculo
            id: '',
            fecha_entrada: '',
            fecha_salida: '',
            lugar: '',
            direccion: '',
            agente: '',
            matricula: '',
            marca: '',
            modelo: '',
            color: '',
            motivo: '',
            tipo_vehiculo: '',
            grua: '',
            estado: 'En deposito',
        },

        // Liquidaciones
        liquidaciones: {},
        liquidacion: {},
        liquidacion_seleccionada: {},
        formLiquidacion: { // Json de campos formulario creación liquidacion
            id_retirada: '',
            nombre: '',
            nif: '',
            domicilio: '',
            poblacion: '',
            provincia: '',
            permiso: '',
            fecha: '',
            agente: '',
            importe_retirada: '',
            importe_deposito: '',
            total: '',
            opciones_pago: '',
        },
        vehiculos_disponibles: {}, // Lista de retiradas que se pueden gestionar


        logeado: false, // Booleano que indica si se ha logeado o no
        pantalla: "", //Pantalla actual

        // Pagination and sorting
        pageSize: 10,
        currentPage: 1,
        searchQuery: '',
        currentSort: 'id',
        currentSortDir: 'asc',
        columns: [
            { label: 'ID', field: 'id' },
            { label: 'Email', field: 'email' },
            { label: 'Contraseña', field: 'password' },
            { label: 'Rol', field: 'rol' }
        ],
        // Pagination and sorting for liquidaciones
        pageSizeLiquidaciones: 10,
        currentPageLiquidaciones: 1,
        searchQueryLiquidaciones: '',
        currentSortLiquidaciones: 'id',
        currentSortDirLiquidaciones: 'asc',
        columnsLiquidaciones: [
            { label: 'ID', field: 'id' },
            { label: 'Retirada', field: 'id_retirada' },
            { label: 'Nombre', field: 'nombre' },
            { label: 'NIF', field: 'nif' },
            { label: 'Domicilio', field: 'domicilio' },
            { label: 'Población', field: 'poblacion' },
            { label: 'Provincia', field: 'provincia' },
            { label: 'Permiso', field: 'permiso' },
            { label: 'Fecha', field: 'fecha' },
            { label: 'Agente', field: 'agente' },
            { label: 'Importe retirada', field: 'importe_retirada' },
            { label: 'Importe deposito', field: 'importe_deposito' },
            { label: 'Total', field: 'total' },
            { label: 'Opciones de pago', field: 'opciones_pago' },
        ],
        // Pagination and sorting for retiradas
        pageSizeRetiradas: 10,
        currentPageRetiradas: 1,
        searchQueryRetiradas: '',
        currentSortRetiradas: 'id',
        currentSortDirRetiradas: 'asc',
        columnsRetiradas: [
            { label: 'ID', field: 'id' },
            { label: 'Fecha entrada', field: 'fecha_entrada' },
            { label: 'Fecha salida', field: 'fecha_salida' },
            { label: 'Lugar', field: 'lugar' },
            { label: 'Dirección', field: 'direccion' },
            { label: 'Agente', field: 'agente' },
            { label: 'Estado', field: 'estado' },
        ],
    },
    computed: {
        // Filter retiradas based on search query
        filteredRetiradas() {
            return this.retiradas.filter(retirada => {
                return Object.values(retirada).some(value => 
                    String(value).toLowerCase().includes(this.searchQueryRetiradas.toLowerCase())
                );
            });
        },
        // Sort filtered retiradas
        sortedRetiradas() {
            return [...this.filteredRetiradas].sort((a, b) => {
                let modifier = this.currentSortDirRetiradas === 'asc' ? 1 : -1;
                if (a[this.currentSortRetiradas] < b[this.currentSortRetiradas]) return -1 * modifier;
                if (a[this.currentSortRetiradas] > b[this.currentSortRetiradas]) return 1 * modifier;
                return 0;
            });
        },
        // Paginate sorted retiradas
        paginatedAndFilteredRetiradas() {
            const start = (this.currentPageRetiradas - 1) * this.pageSizeRetiradas;
            const end = start + this.pageSizeRetiradas;
            return this.sortedRetiradas.slice(start, end);
        },
        // Calculate total pages for retiradas
        totalPagesRetiradas() {
            return Math.ceil(this.filteredRetiradas.length / this.pageSizeRetiradas);
        },
        // Calculate start index for retiradas
        startIndexRetiradas() {
            return (this.currentPageRetiradas - 1) * this.pageSizeRetiradas;
        },
        // Calculate end index for retiradas
        endIndexRetiradas() {
            const end = this.startIndexRetiradas + this.pageSizeRetiradas;
            return Math.min(end, this.filteredRetiradas.length);
        },
        // Filter users based on search query
        filteredUsers() {
            return this.usuarios.filter(user => {
                return Object.values(user).some(value => 
                    String(value).toLowerCase().includes(this.searchQuery.toLowerCase())
                );
            });
        },
        // Sort filtered users
        sortedUsers() {
            return [...this.filteredUsers].sort((a, b) => {
                let modifier = this.currentSortDir === 'asc' ? 1 : -1;
                if (a[this.currentSort] < b[this.currentSort]) return -1 * modifier;
                if (a[this.currentSort] > b[this.currentSort]) return 1 * modifier;
                return 0;
            });
        },
        // Paginate sorted users
        paginatedAndFilteredUsers() {
            const start = (this.currentPage - 1) * this.pageSize;
            const end = start + this.pageSize;
            return this.sortedUsers.slice(start, end);
        },
        // Calculate total pages
        totalPages() {
            return Math.ceil(this.filteredUsers.length / this.pageSize);
        },
        // Calculate start index
        startIndex() {
            return (this.currentPage - 1) * this.pageSize;
        },
        // Calculate end index
        endIndex() {
            const end = this.startIndex + this.pageSize;
            return Math.min(end, this.filteredUsers.length);
        },
        // Filter liquidaciones based on search query
        filteredLiquidaciones() {
            // Check if liquidaciones is an array before filtering
            if (!Array.isArray(this.liquidaciones)) {
                return [];
            }
            return this.liquidaciones.filter(liquidacion => {
                return Object.values(liquidacion).some(value => 
                    String(value).toLowerCase().includes(this.searchQueryLiquidaciones.toLowerCase())
                );
            });
        },
        // Sort filtered liquidaciones
        sortedLiquidaciones() {
            return [...this.filteredLiquidaciones].sort((a, b) => {
                let modifier = this.currentSortDirLiquidaciones === 'asc' ? 1 : -1;
                if (a[this.currentSortLiquidaciones] < b[this.currentSortLiquidaciones]) return -1 * modifier;
                if (a[this.currentSortLiquidaciones] > b[this.currentSortLiquidaciones]) return 1 * modifier;
                return 0;
            });
        },
        // Paginate sorted liquidaciones
        paginatedAndFilteredLiquidaciones() {
            const start = (this.currentPageLiquidaciones - 1) * this.pageSizeLiquidaciones;
            const end = start + this.pageSizeLiquidaciones;
            return this.sortedLiquidaciones.slice(start, end);
        },
        // Calculate total pages for liquidaciones
        totalPagesLiquidaciones() {
            return Math.ceil(this.filteredLiquidaciones.length / this.pageSizeLiquidaciones);
        },
        // Calculate start index for liquidaciones
        startIndexLiquidaciones() {
            return (this.currentPageLiquidaciones - 1) * this.pageSizeLiquidaciones;
        },
        // Calculate end index for liquidaciones
        endIndexLiquidaciones() {
            const end = this.startIndexLiquidaciones + this.pageSizeLiquidaciones;
            return Math.min(end, this.filteredLiquidaciones.length);
        },
    },
    watch: {
        // Reset to first page when search query changes for retiradas
        searchQueryRetiradas() {
            this.currentPageRetiradas = 1;
        },
        // Reset to first page when page size changes for retiradas
        pageSizeRetiradas() {
            this.currentPageRetiradas = 1;
        },
        // Reset to first page when search query changes
        searchQuery() {
            this.currentPage = 1;
        },
        // Reset to first page when page size changes
        pageSize() {
            this.currentPage = 1;
        },
        // Reset to first page when search query changes for liquidaciones
        searchQueryLiquidaciones() {
            this.currentPageLiquidaciones = 1;
        },
        // Reset to first page when page size changes for liquidaciones
        pageSizeLiquidaciones() {
            this.currentPageLiquidaciones = 1;
        }
    },
    methods: {
        mostrarLiquidacion(){
            // Cambiamos pantalla a liquidación y cargamos la tabla
            this.pantalla = "liquidacion";
            this.obtenerLiquidaciones();
        },
        mostrarVehiculo(){
            // Cambiamos pantalla a vehiculo y cargamos la tabla
            this.pantalla = "vehiculos";
            this.obtenerVehiculos();
        },
        mostrarUsuarios(){
            // Cambiamos pantalla a usuarios y cargamos la tabla
            this.pantalla = "usuarios";
            this.obtenerUsuarios();
            
        },

        // LIQUIDACIONES (Ahora vehiculos)
        obtenerLiquidaciones(){
            fetch(this.url+'liquidaciones', {
                method: 'GET',
            })
               .then(response => response.json())
               .then(data => {
                    this.liquidaciones = data;
                })
               .catch(error => {
                    console.error("Error al obtener las liquidaciones:", error);
                });
        },
        obtenerLiquidacion(id){
            return fetch(this.url+'liquidaciones/'+id, {
                method: 'GET',
            })
               .then(response => response.json())
               .then(data => {
                    this.liquidacion_seleccionada = data;
                })
               .catch(error => {
                    console.error("Error al obtener la liquidacion:", error);
                });
        },

        // FORMULARIOS LIQUIDACIONES

        // Mostrar el modal de eliminar una liquidación una vez cargado los datos de esta
        formularioEliminarLiquidacion(id){
            // Cerrar cualquier modal abierto antes de abrir uno nuevo
            $('#liquidacionEliminarModal').modal('hide');

            this.liquidacion_seleccionada = {};

            this.obtenerLiquidacion(id).then(() => {
                // Mostrar el modal solo después de que los datos se hayan cargado
                Vue.nextTick(() => {
                  $('#liquidacionEliminarModal').modal('show');
                });
              });
        },
        // Mostrar el modal de editar una liquidación una vez cargado los datos de esta
        formularioEditarLiquidacion(id){
            $('#liquidacionEditarModal').modal('hide');
            this.liquidacion_seleccionada = {};
            
            this.obtenerLiquidacion(id).then(() => {  // Fixed method name
                Vue.nextTick(() => {
                  $('#liquidacionEditarModal').modal('show');
                });
            });
        },
        //Mostrar el modal de crear una liquidación
        abrirModalLiquidacion() {
            $('#liquidacionCrearModal').modal('hide');  // Show the modal
            this.obtenerVehiculosDisponibles();
            $('#liquidacionCrearModal').modal('show');  // Show the modal
        },

        // CRUD LIQUIDACIONES
        eliminarLiquidacion(){
            fetch(this.url + 'liquidaciones/' + this.liquidacion_seleccionada.id, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    this.obtenerLiquidaciones();
                    this.nuevoLog('Eliminación liquidación', 'El administrador ha eliminado la liquidación '+this.liquidacion_seleccionada.id)
                    this.liquidacion_seleccionada = {};
                    $('#liquidacionEliminarModal').modal('hide');
                }
            })
            .catch(error => {
                console.error("Error al eliminar la liquidacion:", error);
            });
        },
        crearLiquidacion() {
            fetch(this.url + 'liquidaciones', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(this.formLiquidacion)
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    return response.json().then(data => {
                        throw new Error(data.message || 'Error al crear la liquidación');
                    });
                }
            })
            .then(data => {
                this.obtenerLiquidaciones();
                $('#liquidacionCrearModal').modal('hide');
                this.nuevoLog('Creación liquidacion', 'Se ha creado la liquidacion'+this.formLiquidacion.id);
                this.formLiquidacion = {
                    id_retirada: '',
                    nombre: '',
                    nif: '',
                    domicilio: '',
                    poblacion: '',
                    provincia: '',
                    permiso: '',
                    fecha: '',
                    agente: '',
                    importe_retirada: '',
                    importe_deposito: '',
                    total: '',
                    opciones_pago: '',
                };
                console.log('Vehiculo creado correctamente', data);
            })
            .catch(error => {
                console.error("Error al crear el vehículo:", error);
            });
        },
        editarLiquidacion() {
            return fetch(this.url + 'liquidaciones/' + this.liquidacion_seleccionada.id, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(this.liquidacion_seleccionada)

            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    return response.json().then(data => {
                        throw new Error(data.message || 'Error al editar la liquidacion');
                    });
                }
            })
            .then(data => {
                this.obtenerLiquidaciones();
                $('#liquidacionEditarModal').modal('hide');
                this.nuevoLog('Modificación liquidacion', 'El administrador ha modificado la liquidacion '+this.liquidacion_seleccionada.id)
                this.liquidacion_seleccionada = {};
                console.log('liquidacion actualizado correctamente');
            })
            .catch(error => {
                console.error("Error al editar la liquidacion:", error);
                console.log(this.liquidacion_seleccionada);
                
            });
        },

        // RETIRADAS
        obtenerVehiculos() {
            fetch(this.url+'vehiculos', {
                method: 'GET',
            })
                .then(response => response.json())
                .then(data => {
                    this.retiradas = data;
                })
                .catch(error => {
                    console.error("Error al obtener las retiradas:", error);
                });
        },
        obtenerVehiculo(id){
            console.log(id);
            
            return fetch(this.url+'vehiculos/'+id, {
                method: 'GET',
            })
                .then(response => response.json())
                .then(data => {
                    this.vehiculo_seleccionado = data;
                })
                .catch(error => {
                    console.error("Error al obtener el vehículo:", error);
                });
        },
        obtenerVehiculosDisponibles(){
            fetch(this.url+'vehiculos/disponibles', {
                method: 'GET',
            })
                .then(response => response.json())
                .then(data => {
                    this.vehiculos_disponibles = data;
                })
                .catch(error => {
                    console.error("Error al obtener las retiradas disponibles:", error);
                });
        },

        // CRUD RETIRADAS
        crearVehiculo() {
            fetch(this.url + 'retiradas', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(this.formVehiculo)
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    return response.json().then(data => {
                        throw new Error(data.message || 'Error al crear el vehículo');
                    });
                }
            })
            .then(data => {
                this.obtenerVehiculos();
                $('#retiradaCrearModal').modal('hide');
                this.nuevoLog('Creación vehiculo', 'Se ha creado el vehículo'+this.formVehiculo.id);
                this.formVehiculo = {
                    id: '',
                    fecha_entrada: '',
                    fecha_salida: '',
                    lugar: '',
                    direccion: '',
                    agente: '',
                    matricula: '',
                    marca: '',
                    modelo: '',
                    color: '',
                    motivo: '',
                    tipo_vehiculo: '',
                    grua: '',
                    estado: '',
                };
                console.log('Vehiculo creado correctamente', data);
            })
            .catch(error => {
                console.error("Error al crear el vehículo:", error);
            });
        },
        eliminarVehiculo() {
            fetch(this.url + 'vehiculos/' + this.vehiculo_seleccionado.id, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    this.obtenerVehiculos();
                    this.nuevoLog('Eliminación vehiculo', 'El administrador ha eliminado el vehículo '+this.vehiculo_seleccionado.id)
                    this.vehiculo_seleccionado = {};
                    $('#vehiculoEliminarModal').modal('hide');
                }
            })
            .catch(error => {
                console.error("Error al eliminar el vehículo:", error);
            });
        },
        editarVehiculo() {
            fetch(this.url + 'vehiculos/' + this.vehiculo_seleccionado.id, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(this.vehiculo_seleccionado)

            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    return response.json().then(data => {
                        throw new Error(data.message || 'Error al editar el vehículo');
                    });
                }
            })
            .then(data => {
                this.obtenerVehiculos();
                $('#vehiculoEditarModal').modal('hide');
                this.nuevoLog('Modificación vehiculo', 'El administrador ha modificado el vehículo '+this.vehiculo_seleccionado.id)
                this.vehiculo_seleccionado = {};
                console.log('Retirada actualizado correctamente');
            })
            .catch(error => {
                console.error("Error al editar el vehículo:", error);
                console.log(this.vehiculo_seleccionado);
                
            });
        },


        // FORMULARIOS RETIRADAS
        formularioEliminarVehiculo(id){
            // Cerrar cualquier modal abierto antes de abrir uno nuevo
            $('#vehiculoEliminarModal').modal('hide');

            this.vehiculo_seleccionado = {};

            this.obtenerVehiculo(id).then(() => {
                // Mostrar el modal solo después de que los datos se hayan cargado
                Vue.nextTick(() => {
                  $('#vehiculoEliminarModal').modal('show');
                });
              });
        },
        formularioEditarVehiculo(id){
            // Cerrar cualquier modal abierto antes de abrir uno nuevo
            $('#vehiculoEditarModal').modal('hide');

            this.vehiculo_seleccionado = {};

            this.obtenerVehiculo(id).then(() => {
                // Mostrar el modal solo después de que los datos se hayan cargado
                Vue.nextTick(() => {
                  $('#vehiculoEditarModal').modal('show');
                });
              });
        },
        
       

        // USUARIOS

        // FORMULARIOS USUARIOS
        formularioCrearUsuario(){
            // Cerrar cualquier modal abierto antes de abrir uno nuevo
            $('#createModal').modal('hide');
            $('#createModal').modal('show');
        },
        formularioEditarUsuario(id) {
            // Cerrar cualquier modal abierto antes de abrir uno nuevo
            $('#editModal').modal('hide');
      
            this.usuario_seleccionado = {};
      
            this.obtenerUsuario(id).then(() => {
              // Mostrar el modal solo después de que los datos se hayan cargado
              Vue.nextTick(() => {
                $('#editModal').modal('show');
              });
            });
          },
        formularioEliminarUsuario(id){
            // Cerrar cualquier modal abierto antes de abrir uno nuevo
            $('#deleteModal').modal('hide');

            this.usuario_seleccionado = {};

            this.obtenerUsuario(id).then(() => {
                // Mostrar el modal solo después de que los datos se hayan cargado
                Vue.nextTick(() => {
                  $('#deleteModal').modal('show');
                });
              });
        },

        // CRUD USUARIOS
        eliminarUsuario() {
            fetch(this.url + 'usuarios/' + this.usuario_seleccionado.id, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    this.obtenerUsuarios();
                    this.nuevoLog('Eliminación usuario', 'El administrador ha eliminado al usuario '+this.usuario_seleccionado.email)
                    this.usuario_seleccionado = {};
                    $('#deleteModal').modal('hide');
                }
            })
            .catch(error => {
                console.error("Error al eliminar usuario:", error);
            });
        },
        editarUsuario() {
            fetch(this.url + 'usuarios/' + this.usuario_seleccionado.id, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify({
                    email: this.usuario_seleccionado.email,
                    rol: this.usuario_seleccionado.rol,
                    password: this.usuario_seleccionado.password 
                })
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    return response.json().then(data => {
                        throw new Error(data.message || 'Error al editar al usuario');
                    });
                }
            })
            .then(data => {
                this.obtenerUsuarios();
                $('#editModal').modal('hide');
                this.nuevoLog('Modificación usuario', 'El administrador ha modificado al usuario '+this.usuario_seleccionado.email)
                this.usuario_seleccionado = {};
                console.log('Usuario actualizado correctamente');
            })
            .catch(error => {
                console.error("Error al editar al usuario:", error);
            });
        },
        crearUsuario() {
            fetch(this.url + 'usuarios', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify({
                    email: this.email,
                    rol: this.rol,
                    password: this.contrasena // Asegúrate de que el campo se llame 'password'
                })
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    return response.json().then(data => {
                        throw new Error(data.message || 'Error al crear al usuario');
                    });
                }
            })
            .then(data => {
                this.obtenerUsuarios();
                $('#createModal').modal('hide');
                this.email = "";
                this.rol = "";
                this.contrasena = "";
                this.nuevoLog('Creacion usuario', 'El administrador ha creado un nuevo usuario ')
                console.log('Usuario creado correctamente' + data);
            })
            .catch(error => {
                console.error("Error al crear al usuario:", error);
            });
        },
        
        // RECOGER USUARIOS
        obtenerUsuarios() {
            fetch(this.url+'usuarios', {
                method: 'GET',
            })
                .then(response => response.json())
                .then(data => {
                    this.usuarios = data;
                })
                .catch(error => {
                    console.error("Error al obtener los usuarios:", error);
                });
        },
        obtenerUsuario(id) {
            return fetch(this.url + 'usuarios/' + id, {
                method: 'GET',
            })
            .then(response => response.json())
            .then(data => {
                this.usuario_seleccionado = data;
                return data;
            })
            .catch(error => {
                console.error("Error al obtener los usuarios:", error);
            });
        },

        intentoLogin() {
            fetch(this.url+'usuarios')
                .then(response => response.json())
                .then(users => {
                    const user = users.find(user => user.email == this.email && user.password == this.contrasena);
                    if (user) {
                        this.logeado = true;
                        this.usuario = user;
                        this.nuevoLog("Login", "El usuario ha iniciado sesión");
                        this.email = "";
                        this.contrasena = "";
                    } else {
                        this.logeado = false;
                        console.log("Email o contraseña incorrectos");
                    }
                })
                .catch(error => {
                    console.error("Error al intentar hacer logging:", error);
                });
        },
        isAdmin() {
            return this.usuario.rol === 'administrador';
        },
        nuevoLog(pamAccion, pamDescripcion) {
            // Configuración de la solicitud fetch
            let date = new Date();
            date.setHours(date.getHours() + 1);
            let data = {
                usuario_id: this.usuario.id,
                accion: pamAccion,
                descripcion: pamDescripcion,
                fecha: date.toISOString().slice(0, 19).replace('T', ' ')
            };
            fetch(this.url+'logs', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error("Error al enviar los datos: " + response.status);
                }
                return response.json();
            })
            .then(result => {
            })
            .catch(error => {
                console.error("Ocurrió un error:", error);
            })
        },
        // Sort method for retiradas
        sortByRetiradas(field) {
            if (field === this.currentSortRetiradas) {
                this.currentSortDirRetiradas = this.currentSortDirRetiradas === 'asc' ? 'desc' : 'asc';
            }
            this.currentSortRetiradas = field;
        },

        // Sort method for liquidaciones
        sortByLiquidaciones(field) {
            if (field === this.currentSortLiquidaciones) {
                this.currentSortDirLiquidaciones = this.currentSortDirLiquidaciones === 'asc' ? 'desc' : 'asc';
            }
            this.currentSortLiquidaciones = field;
        },
        // Sort method
        sortBy(field) {
            if (field === this.currentSort) {
                this.currentSortDir = this.currentSortDir === 'asc' ? 'desc' : 'asc';
            }
            this.currentSort = field;
        },
    }
})

