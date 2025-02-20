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
        retiradas_disponibles: {}, // Lista de retiradas que se pueden gestionar


        logeado: false, // Booleano que indica si se ha logeado o no
        pantalla: "", //Pantalla actual

    },
    methods: {
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

        // LIQUIDACIONES
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
            this.obtenerRetiradasDisponibles();
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
                this.nuevoLog('Creación retirada', 'Se ha creado la retirada'+this.formRetirada.id);
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
                    this.nuevoLog('Eliminación retirada', 'El administrador ha eliminado la retirada '+this.retirada_seleccionada.id)
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
                this.nuevoLog('Modificación retirada', 'El administrador ha modificado la retirada '+this.retirada_seleccionada.id)
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
            });
        },
    }
});