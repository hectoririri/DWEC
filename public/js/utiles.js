let app = new Vue({
    el: "#app", // Elemento del DOM al que hace referencia
    data: {
        cuerpo: "", // Variable para almacenar el HTML dinámico
        email: "", // Modelo para el campo email
        contrasena: "", // Modelo para el campo contraseña
        logeado: false, // Booleano que indica si se ha logeado o no
        usuario: "", //Json del usuario logueado
        pantalla: "", //Pantalla actual
    },
    methods: {
        intentoLogin() {
            fetch('http://localhost/DWEC/grua/DWEC/private/ApiGrua/public/usuarios')
                .then(response => response.json())
                .then(users => {
                    const user = users.find(user => user.email == this.email && user.password == this.contrasena);
                    if (user) {
                        this.logeado = true;
                        this.usuario = user;
                        this.nuevoLog();
                        console.log("logueado");
                    } else {
                        this.logeado = false;
                        console.log("no logueado");
                    }
                })
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
            fetch('http://localhost/DWEC/grua/DWEC/private/ApiGrua/public/logs/create', {
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
        }
    }
});