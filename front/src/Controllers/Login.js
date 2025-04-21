import Config from '../config.js';

import WhiteNoiseView from '../Views/WhiteNoise.js';
import NavbarView from '../Views/Navbar.js';
import LoginView from '../Views/Login.js';

import NotificationController from './Notification.js';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
        this.run();
    }

    run() {
        this.render();
        document.querySelector('form').addEventListener('submit', async function(event) {
            event.preventDefault();

            const email = document.querySelector('#email').value;
            const password = document.querySelector('#password').value;

            const data = {
                email,
                password
            };

            try {
                const response = await fetch(Config.BACKEND_URL + ':' + Config.BACKEND_PORT + "/login", {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify(data)
                })

                const result = await response.json();

                console.log(result);

                if (response.ok) {
                    new NotificationController("Connection", result.message, "accent");
                } else {
                    new NotificationController("Error", result.error, "negative");
                }
            } catch(error) {
                new NotificationController("Server Error", "Can't connect to the backend server", "negative");
            }
        })
    }

    render() {
        this.app.innerHTML = `
            ${WhiteNoiseView}
            ${NavbarView}
            ${LoginView}
        `;
    }
}