let app = new Vue({
    el: "#app", // Elemento del DOM al que hace referencia
    data: {
        cuerpo: "", // Variable para almacenar el HTML dinámico
        email: "", // Modelo para el campo email
        contrasena: "", // Modelo para el campo contraseña
        logeado: false,
    },
    methods: {
        intentoLogin() {
            fetch('http://localhost/todos/usuarios')
                .then(response => response.json())
                .then(user => {
                    if (user){
                        console.log(user);
                    }
                })
            if (this.email === 'admin' && this.contrasena === 'admin') {
                this.logeado = true;
                console.log("logeado");
            } else {
                this.logeado = false;
                console.log("no logeado");
            }
        }
    }
});