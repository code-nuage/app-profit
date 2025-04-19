import Config from '../config.js';

import WhiteNoiseView from '../Views/WhiteNoise.js';
import NavbarView from '../Views/Navbar.js';
import SignupView from '../Views/Signup.js';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
        this.run();
    }

    run() {
        this.render();
        document.querySelector('form').addEventListener('submit', async function(event) {
            event.preventDefault();

            const name = document.querySelector('#name').value;
            const email = document.querySelector('#email').value;
            const birthdate = document.querySelector('#birthdate').value;
            const password = document.querySelector('#password').value;
            const passwordConfirm = document.querySelector('#password-confirm').value;

            if (password !== passwordConfirm) {
                alert("Les mots de passe doivent correspondre!");
                return;
            };

            const data = {
                name,
                email,
                birthdate,
                password,
                role: "USER"
            };

            try {
                const response = await fetch(Config.BACKEND_URL + ':' + Config.BACKEND_PORT + "/user", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                })

                const result = await response.json();

                if (response.ok) {
                    alert("Inscription réussie !");
                } else {
                    alert("Erreur : " + result.error);
                }
            } catch(error) {
                alert('Can\'t connect to backend server: ' + error);
            }
        })
    }

    render() {
        this.app.innerHTML = `
            ${WhiteNoiseView}
            ${NavbarView}
            ${SignupView}
        `;
    }
}
