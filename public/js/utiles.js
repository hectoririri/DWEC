let app = new Vue({
    el: "#app", // Elemento del DOM al que hace referencia
    data: {
        url: "http://localhost/DWEC/private/ApiGrua/public/", // URL de la ubicación de la aplicación
        email: "", // Modelo para el campo email
        contrasena: "", // Modelo para el campo contraseña
        usuario: "", //Json del usuario logueado
        logeado: false, // Booleano que indica si se ha logeado o no
        pantalla: "", //Pantalla actual

    },
    methods: {
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
            fetch(this.url+'logs/store', {
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