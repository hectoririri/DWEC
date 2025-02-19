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
            fecha: ''
        },

        logeado: false, // Booleano que indica si se ha logeado o no
        pantalla: "", //Pantalla actual

    },
    methods: {
        mostrarLiquidacion(){
            this.pantalla = "liquidacion";
            console.log(this.pantalla);
        },
        mostrarRetirada(){
            this.pantalla = "retiradas";
            this.obtenerRetiradas();
            console.log(this.pantalla);
        },
        mostrarUsuarios(){
            this.pantalla = "usuarios";
            this.obtenerUsuarios();
            console.log(this.pantalla);
            
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
                    fecha: ''
                };
                this.nuevoLog('Creación retirada', 'Se ha creado una nueva retirada');
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
                    this.nuevoLog('Eliminación retirada', 'El administrador ha eliminado la retirada '+this.usuario_seleccionado.id)
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