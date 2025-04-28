import LoginModel from '../Models/Login.js'; 

import WhiteNoiseView from '../Views/WhiteNoise.js';
import NavbarView from '../Views/Navbar.js';
import LoginView from '../Views/Login.js';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
        this.run();
    }

    run() {
        this.render();

        this.attachForm();
    }

    render() {
        this.app.innerHTML = `
            ${WhiteNoiseView}
            ${NavbarView}
            ${LoginView}
        `;
    }

    attachForm() {
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', async (event) => {
                event.preventDefault();

                LoginModel(this);
            });
        }
    }
}