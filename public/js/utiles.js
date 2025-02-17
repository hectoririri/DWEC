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
        logeado: false, // Booleano que indica si se ha logeado o no
        pantalla: "", //Pantalla actual
        vehiculos: [], // Lista de vehículos
    },
    methods: {
        mostrarRegistro(){
            this.pantalla = "registro";
        },
        mostrarRetirada(){
            this.pantalla = "retirada";
        },
        mostrarUsuarios(){
            this.pantalla = "usuarios";
            this.obtenerUsuarios();
        },
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
          guardarCambios() {
            // Aquí puedes agregar la lógica para guardar los cambios del usuario
            $('#editModal').modal('hide');
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
                console.log('Usuario actualizado correctamente');
            })
            .catch(error => {
                console.error("Error al editar al usuario:", error);
            });
        },
        crearUsuario(){
            fetch(this.url + 'usuarios/', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify({
                    email: this.email,
                    rol: this.rol,
                    password: this.password 
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
                console.log('Usuario creado correctamente');
            })
            .catch(error => {
                console.error("Error al crear al usuario:", error);
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
                console.log("Respuesta del servidor:", result);
            })
            .catch(error => {
                console.error("Ocurrió un error:", error);
            });
        },
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
        
    }
});