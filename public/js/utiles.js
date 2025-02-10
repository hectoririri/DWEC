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
            fetch('http://localhost/DWEC/grua/DWEC/private/ApiGrua/public/usuarios')
                .then(response => response.json())
                .then(users => {
                    const user = user.find(user => user.email == this.email && user.password == this.contrasena);
                    if (user){
                        
                    }
                })
            
        }
    }
});