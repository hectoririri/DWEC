let app = new Vue({
    el: "#app", // Elemento del DOM al que hace referencia
    data: {
        url: "http://localhost/DWEC/private/ApiGrua/public/api/", // URL de la ubicación de la aplicación
        email: "", // Modelo para el campo email
        contrasena: "", // Modelo para el campo contraseña
        usuario: "", //Json del usuario logueado
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
            console.log("modal de formulario usuario"); 
        },
        formularioEditarUsuario(id){
            console.log("modal de modificar formulario usuario "+id);
            this.selectedUserId = id;
        },
        formularioEliminarUsuario(id){
            console.log("modal de eliminar formulario usuario "+id); 
            // Meter html del modal aqui e insertar en index.html
            document.getElementById('mostrarModal').innerHTML = `
                <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel" aria-hidden="true">
                  <div class="modal-dialog" role="document">
                    <div class="modal-content">
                      <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirmar eliminación</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                          <span aria-hidden="true">&times;</span>
                        </button>
                      </div>
                      <div class="modal-body">
                        ¿Está seguro de que desea eliminar al usuario ${id}?
                      </div>
                      <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                        <button type="button" class="btn btn-danger" onclick="app.eliminarUsuario(${id})">Eliminar</button>
                      </div>
                    </div>
                  </div>
                </div>`
        },
        intentoLogin() {
            fetch(this.url+'usuarios')
                .then(response => response.json())
                .then(users => {
                    const user = users.find(user => user.email == this.email && user.password == this.contrasena);
                    if (user) {
                        this.logeado = true;
                        this.usuario = user;
                        this.nuevoLog();
                        console.log("Usuario "+this.email+" logueado");
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
        nuevoLog() {
            // Configuración de la solicitud fetch
            let data = {
                usuario_id: this.usuario.id,
                accion: "Loggin",
                descripcion: "El usuario ha iniciado sesión",
                fecha: new Date().toISOString().slice(0, 19).replace('T', ' ')
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
                    console.log(this.usuarios);
                })
                .catch(error => {
                    console.error("Error al obtener los usuarios:", error);
                });
        }
    }
});