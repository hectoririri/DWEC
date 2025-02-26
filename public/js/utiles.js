let app = new Vue({
    el: "#app", // Elemento del DOM al que hace referencia
    data: {
        url: "http://localhost/DWEC/private/ApiGrua/public/api/", // URL de la ubicación de la aplicación
        email: "", // Modelo para el campo email login
        contrasena: "", // Modelo para el campo contraseña login
        rol: "", // Rol del usuario
        usuario: "", //Json del usuario logueado
        usuario_seleccionado: {
            email: '',
            password: '',
            rol: ''
        }, //Json del usuario seleccionado al editar, eliminar...
        usuarios: [], // Lista usuarios

        // Retirada = Vehiculos
        retiradas: [], // Lista de retiradas
        retirada_seleccionada: {}, // Json de la retirada seleccionada
        formRetirada: { // Json de campos formulario creación retirada
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
            estado: 'En depósito',
        },

        // Liquidaciones = Retiradas 
        liquidaciones: {},
        liquidacion: {},
        liquidacion_especifico: "",
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
        retiradas_disponibles: {}, // Lista de retiradas que se pueden gestionar

        // Precios por tipo de vehículo
        precios: [
            { tipo: "Motocicleta, aperos, motocarros y similares", precio: 25 },
            { tipo: "Turismo hasta 12 cv o Remolques hasta 750 kg", precio: 100 },
            { tipo: "Turismos más de 12 cv o Remolques más de 750 kg", precio: 130 },
            { tipo: "Vehiculos especiales", precio: 150 },
            { tipo: "Vehiculos de cortesia", precio: 0 },
            { tipo: "Chatarra", precio: 0 }
        ],
        precio_encontrado: 0,
        fecha_entrada: 0,

        // Tarifas
        tarifa: {},

        logeado: false, // Booleano que indica si se ha logeado o no
        pantalla: "", //Pantalla actual
        mensajeAlerta: "",

        fecha_entrada_vehiculo: "",
        fecha_entrada_vehiculo_crear: "",

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
            { label: 'Vehiculo', field: 'id_vehiculo' },
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
    mounted() {
        this.cargarTarifa();
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
        limpiarMensaje(){
            this.mensajeAlerta = "";
        },
        cargarTarifa(){
            fetch(this.url+'tarifa/ultima', {
                method: 'GET',
            })
            .then(response => response.json())
            .then(data => {
                this.tarifa = data;
                console.log("Tarifa cargada: ", this.tarifa);
            })
            .catch(error => {
                console.error("Error al cargar la tarifa:", error);
            });
        },
        // Cuando se selecciona un vehiculo en el formulario de retirada crear
        rellenarFormCreacionVehiculo() {
            if (!this.formLiquidacion.id_retirada) return;
            
            fetch(this.url + 'retiradas/' + this.formLiquidacion.id_retirada, {
                method: 'GET',
            })
            .then(response => response.json())
            .then(data => {
                console.log("ID seleccionado:", this.formLiquidacion.id_retirada);
                console.log("Vehiculo seleccionado:", data.tipo_vehiculo);
                this.fecha_entrada_vehiculo = data.fecha_entrada;
                // Buscamos el precio correspondiente en la lista de precios
                this.precio_encontrado = this.precios.find(precio => precio.tipo === data.tipo_vehiculo);
                this.fecha_entrada = data.fecha_entrada;

                // Calculamos el precio según
                this.calcularPrecioHoras();

                // Asignamos el agente al formulario de retirada
                this.formLiquidacion.agente = data.agente;
            })
            .catch(error => {
                console.error("Error al obtener los datos del vehiculo:", error);
            });
        },
        calcularPrecioHoras(){
            // Calculate hours between dates
                // Parse dates ensuring proper format
                const fechaEntrada = new Date(this.fecha_entrada_vehiculo.replace(' ', 'T'));
                const fechaSalida = new Date(this.formLiquidacion.fecha.replace(' ', 'T'));
                if (fechaSalida < fechaEntrada) {
                    this.formLiquidacion.fecha = new Date(Date.now() + 3600000).toISOString().slice(0,16)
                    console.error("La fecha de liquidación debe ser posterior a la fecha de entrada");
                    return;
                }
                
                // Calculate time difference in milliseconds
                const diffTime = Math.abs(fechaSalida.getTime() - fechaEntrada.getTime());
                
                // Convert to hours and round up
                const diffHours = Math.ceil(diffTime / (1000 * 60 * 60));
                console.log("Horas transcurridas: ", diffHours);

                // Calculate deposit amount
                if (diffHours <= this.tarifa.horas_gratis) {
                    this.formLiquidacion.importe_deposito = 0;
                } else {
                    this.formLiquidacion.importe_deposito = diffHours * this.tarifa.costo_por_hora;
                }
                
                if (this.precio_encontrado.precio) {
                    this.formLiquidacion.importe_retirada = this.precio_encontrado.precio;
                    console.log("Precio encontrado:", this.precio_encontrado.precio);
                } else {
                    console.log("Tipo de vehículo no encontrado en la lista de precios");
                    this.formLiquidacion.importe_retirada = 0;
                }
                // Asignamos el total al formulariom de retirada
                this.formLiquidacion.total = this.formLiquidacion.importe_retirada + this.formLiquidacion.importe_deposito;
        },
        // Nuevo método para calcular precios en edición
        calcularPrecioHorasEdicion(){
            const fechaEntrada = new Date(this.fecha_entrada_vehiculo.replace(' ', 'T'));
            const fechaActual = new Date(this.liquidacion_seleccionada.fecha.replace(' ', 'T'));
            
            if (fechaEntrada > fechaActual) {
                this.liquidacion_seleccionada.fecha = new Date(Date.now() + 3600000).toISOString().slice(0,16);
                console.error("La fecha de liquidación debe ser posterior a la fecha de entrada");
                return;
            }

            
            const diffTime = Math.abs(fechaActual.getTime() - fechaEntrada.getTime());
            const diffHours = Math.ceil(diffTime / (1000 * 60 * 60));
            
            if (diffHours <= this.tarifa.horas_gratis) {
                this.liquidacion_seleccionada.importe_deposito = 0;
            } else {
                this.liquidacion_seleccionada.importe_deposito = diffHours * this.tarifa.costo_por_hora;
            }
            
            if (this.precio_encontrado.precio) {
                this.liquidacion_seleccionada.importe_retirada = this.precio_encontrado.precio;
            } else {
                this.liquidacion_seleccionada.importe_retirada = 0;
            }
            
            this.liquidacion_seleccionada.total = this.liquidacion_seleccionada.importe_retirada + this.liquidacion_seleccionada.importe_deposito;
        },
        mostrarLiquidacion(){
            // Cambiamos pantalla a liquidación y cargamos la tabla
            this.pantalla = "liquidacion";
            this.obtenerLiquidaciones();
        },
        mostrarRetirada(){
            // Cambiamos pantalla a retiradas y cargamos la tabla
            this.pantalla = "retiradas";
            this.obtenerRetiradas();
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
            this.isEditing = true;

            $('#liquidacionEditarModal').modal('hide');
            this.liquidacion_seleccionada = {};
            
            this.obtenerLiquidacion(id).then(() => {
                // Obtener la retirada asociada para calcular los precios
                fetch(this.url + 'retiradas/' + this.liquidacion_seleccionada.id_retirada, {
                    method: 'GET',
                })
                .then(response => response.json())
                .then(data => {
                    this.fecha_entrada = data.fecha_entrada;
                    this.fecha_entrada_vehiculo = data.fecha_entrada;
                    this.precio_encontrado = this.precios.find(precio => precio.tipo === data.tipo_vehiculo);
                    this.calcularPrecioHorasEdicion();
                    this.calcularPrecioHoras();
                });

                Vue.nextTick(() => {
                    $('#liquidacionEditarModal').modal('show');
                });
            });
        },
        abrirModalLiquidacionEspecifico(id) {
            console.log(id);
            this.abrirModalLiquidacion();
            this.formLiquidacion.id_retirada = id;
            this.rellenarFormCreacionVehiculo();
        },

        //Mostrar el modal de crear una liquidación
        abrirModalLiquidacion() {
            $('#liquidacionCrearModal').modal('hide'); 
            this.obtenerRetiradasDisponibles();
            this.fecha_entrada_vehiculo = "";
            // Reseteamos el formulario
            this.formLiquidacion = {
                id_retirada: '',
                nombre: '',
                nif: '',
                domicilio: '',
                poblacion: '',
                provincia: '',
                permiso: '',
                fecha: new Date(Date.now() + 3600000).toISOString().slice(0,16),
                agente: '',
                importe_retirada: '',
                importe_deposito: '',
                total: '',
                opciones_pago: '',
            };
            this.rellenarFormCreacionVehiculo();
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
                    this.nuevoLog('Eliminación retirada', 'El administrador ha eliminado la retirada '+this.liquidacion_seleccionada.id)
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
                this.nuevoLog('Creación retirada', 'Se ha creado la retirada'+this.formLiquidacion.id);
                this.mensajeAlerta = "Retirada creada correctamente";
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
                console.log('Retirada creada correctamente', data);
            })
            .catch(error => {
                console.error("Error al crear la retirada:", error);
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
                this.mensajeAlerta = "Retirada modificada correctamente"
                this.nuevoLog('Modificación retirada', 'El administrador ha modificado la retirada '+this.liquidacion_seleccionada.id)
                this.liquidacion_seleccionada = {};
                console.log('liquidacion actualizado correctamente');
            })
            .catch(error => {
                console.error("Error al editar la liquidacion:", error);
                console.log(this.liquidacion_seleccionada);
                
            });
        },

        // RETIRADAS
        obtenerRetiradas() {
            fetch(this.url+'retiradas', {
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
        obtenerRetirada(id){
            console.log(id);
            
            return fetch(this.url+'retiradas/'+id, {
                method: 'GET',
            })
                .then(response => response.json())
                .then(data => {
                    this.retirada_seleccionada = data;
                })
                .catch(error => {
                    console.error("Error al obtener la retirada:", error);
                });
        },
        obtenerRetiradasDisponibles(){
            fetch(this.url+'retiradas/disponibles', {
                method: 'GET',
            })
                .then(response => response.json())
                .then(data => {
                    this.retiradas_disponibles = data;
                })
                .catch(error => {
                    console.error("Error al obtener las retiradas disponibles:", error);
                });
        },

        abrirModalRetirada() {
            $('#retiradaCrearModal').modal('hide');
            this.getUltimoId();
            $('#retiradaCrearModal').modal('show');
        },

        getUltimoId(){
            fetch(this.url + 'retiradas/ultima')
                .then(response => response.json())
                .then(data => {
                    if (data.siguiente_id === 1) {
                        // If no records exist, start with 20250001
                        this.formRetirada.id = '20250001';
                    } else {
                        // Get the next ID
                        const currentId = parseInt(data.ultima_retirada.id);
                        this.formRetirada.id = (currentId + 1).toString();
                    }
                })
                .catch(error => {
                    console.error("Error al obtener el último ID:", error);
                    // Set default ID if there's an error
                    this.formRetirada.id = '20250001';
                });
        },

        // CRUD RETIRADAS
        crearRetirada() {
            fetch(this.url + 'retiradas', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(this.formRetirada)
            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    return response.json().then(data => {
                        throw new Error(data.message || 'Error al crear la retirada');
                    });
                }
            })
            .then(data => {
                this.obtenerRetiradas();
                $('#retiradaCrearModal').modal('hide');
                this.mensajeAlerta = "Vehículo creado correctamente";
                this.nuevoLog('Creación vehículo', 'Se ha creado el vehículo'+this.formRetirada.id);
                this.formRetirada = {
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
                console.log('Retirada creada correctamente', data);
            })
            .catch(error => {
                console.error("Error al crear la retirada:", error);
            });
        },
        eliminarRetirada() {
            fetch(this.url + 'retiradas/' + this.retirada_seleccionada.id, {
                method: 'DELETE'
            })
            .then(response => {
                if (response.ok) {
                    this.obtenerRetiradas();
                    this.nuevoLog('Eliminación vehículo', 'El administrador ha eliminado el vehículo '+this.retirada_seleccionada.id)
                    this.retirada_seleccionada = {};
                    $('#retiradaEliminarModal').modal('hide');
                }
            })
            .catch(error => {
                console.error("Error al eliminar la retirada:", error);
            });
        },
        editarRetirada() {
            fetch(this.url + 'retiradas/' + this.retirada_seleccionada.id, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify(this.retirada_seleccionada)

            })
            .then(response => {
                if (response.ok) {
                    return response.json();
                } else {
                    return response.json().then(data => {
                        throw new Error(data.message || 'Error al editar la retirada');
                    });
                }
            })
            .then(data => {
                this.obtenerRetiradas();
                $('#retiradaEditarModal').modal('hide');
                this.mensajeAlerta = "Vehículo modificado correctamente"
                this.nuevoLog('Modificación vehículo', 'El administrador ha modificado el vehículo '+this.retirada_seleccionada.id)
                this.retirada_seleccionada = {};
                console.log('Retirada actualizado correctamente');
            })
            .catch(error => {
                console.error("Error al editar la retirada:", error);
                console.log(this.retirada_seleccionada);
                
            });
        },


        // FORMULARIOS RETIRADAS
        formularioEliminarRetirada(id){
            // Cerrar cualquier modal abierto antes de abrir uno nuevo
            $('#retiradaEliminarModal').modal('hide');

            this.retirada_seleccionada = {};

            this.obtenerRetirada(id).then(() => {
                // Mostrar el modal solo después de que los datos se hayan cargado
                Vue.nextTick(() => {
                  $('#retiradaEliminarModal').modal('show');
                });
              });
        },
        formularioEditarRetirada(id){
            // Cerrar cualquier modal abierto antes de abrir uno nuevo
            $('#retiradaEditarModal').modal('hide');

            this.retirada_seleccionada = {};

            this.obtenerRetirada(id).then(() => {
                // Mostrar el modal solo después de que los datos se hayan cargado
                Vue.nextTick(() => {
                  $('#retiradaEditarModal').modal('show');
                });
              });
        },
        
       

        // USUARIOS

        // FORMULARIOS USUARIOS
        formularioCrearUsuario(){
            // Cerrar cualquier modal abierto antes de abrir uno nuevo
            $('#createModal').modal('hide');
            this.email = "";
            this.contrasena = "";
            this.rol = "";
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
                this.mensajeAlerta = "Usuario modificado correctamente";
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
                    password: this.contrasena
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
                this.mensajeAlerta = "Usuario creado correctamente"
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
                console.log(this.usuario_seleccionado);
                
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

        generarPDFLiquidacion(liquidacion) {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            
            // Set font styles
            doc.setFont('helvetica');
            doc.setFontSize(11);
        
            // Header text
            doc.text('La Policía Local ha procedido a retirar el vehículo que más abajo se reseña, en', 20, 20);
            doc.text('cumplimiento de la Ordenanza Municipal Reguladora 2-07 (BOP núm. 247 de', 20, 25);
            doc.text('29/12/2009) sobre Retirada y Depósito de vehículos de la vía pública.', 20, 30);
        
            // Vehicle Data Section
            doc.setFillColor(200, 200, 200);
            doc.rect(20, 40, 170, 10, 'F');
            doc.setFont('helvetica', 'bold');
            doc.text('DATOS DEL VEHÍCULO', 85, 46);
        
            // Vehicle details
            doc.setFont('helvetica', 'normal');
            doc.text('Matrícula', 30, 60);
            doc.text('Marca', 90, 60);
            doc.text('Modelo', 150, 60);
            doc.line(20, 65, 190, 65); // Horizontal line
        
            doc.text('Lugar de recogida', 30, 75);
            doc.text('Fecha y hora de recogida', 130, 75);
            doc.line(20, 80, 190, 80);
        
            // Owner Data Section
            doc.setFillColor(200, 200, 200);
            doc.rect(20, 90, 170, 10, 'F');
            doc.setFont('helvetica', 'bold');
            doc.text('DATOS DEL PROPIETARIO', 85, 96);
        
            // Owner details
            doc.setFont('helvetica', 'normal');
            doc.text('Nombre y apellidos', 30, 110);
            doc.text('NIF', 150, 110);
            doc.line(20, 115, 190, 115);
        
            doc.text('Domicilio', 30, 125);
            doc.line(20, 130, 190, 130);
        
            doc.text('Población', 30, 140);
            doc.text('Provincia', 90, 140);
            doc.text('Permiso', 150, 140);
            doc.line(20, 145, 190, 145);
        
            // Delivery Data Section
            doc.setFillColor(200, 200, 200);
            doc.rect(20, 155, 170, 10, 'F');
            doc.setFont('helvetica', 'bold');
            doc.text('DATOS DE ENTREGA', 85, 161);
        
            // Delivery details
            doc.setFont('helvetica', 'normal');
            doc.text('Fecha y hora', 30, 175);
            doc.text('Agente', 90, 175);
            doc.text('Forma de pago', 150, 175);
            doc.line(20, 180, 190, 180);
        
            doc.text('Importe Retirada', 30, 190);
            doc.text('Importe Depósito', 90, 190);
            doc.text('Total a pagar', 150, 190);
            doc.line(20, 195, 190, 195);
        
            // Fill in the data
            doc.setFont('helvetica', 'bold');
            doc.text(liquidacion.matricula || '', 30, 65);
            doc.text(liquidacion.marca || '', 90, 65);
            doc.text(liquidacion.modelo || '', 150, 65);
            doc.text(liquidacion.lugar || '', 30, 80);
            doc.text(liquidacion.fecha || '', 130, 80);
            doc.text(liquidacion.nombre || '', 30, 115);
            doc.text(liquidacion.nif || '', 150, 115);
            doc.text(liquidacion.domicilio || '', 30, 130);
            doc.text(liquidacion.poblacion || '', 30, 145);
            doc.text(liquidacion.provincia || '', 90, 145);
            doc.text(liquidacion.permiso || '0', 150, 145);
            doc.text(liquidacion.fecha || '', 30, 180);
            doc.text(liquidacion.agente || '', 90, 180);
            doc.text(liquidacion.opciones_pago || '', 150, 180);
            doc.text(liquidacion.importe_retirada + '€' || '0€', 30, 195);
            doc.text(liquidacion.importe_deposito + '€' || '0€', 90, 195);
            doc.text(liquidacion.total + '€' || '0€', 150, 195);
        
            // Footer
            doc.setFontSize(10);
            doc.setFont('helvetica', 'normal');
            doc.text('Recibe copia y firma', 20, 240);
            doc.text('Conforme el conductor', 20, 250);
            
            const currentDate = new Date().toLocaleDateString('es-ES');
            doc.text(`En Almonte a ${currentDate}`, 130, 245);
        
            // Save the PDF
            doc.save(`liquidacion_${liquidacion.id}.pdf`);
          }
    }
})

