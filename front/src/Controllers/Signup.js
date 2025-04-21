import SignupModel from '../Models/Signup.js';

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
            SignupModel();
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
