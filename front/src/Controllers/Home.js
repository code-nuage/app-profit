import WhiteNoiseView from '../Views/WhiteNoise.js';
import NavbarView from '../Views/Navbar.js';
import HomeView from '../Views/Home.js';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        this.app.innerHTML = `
            ${WhiteNoiseView}
            ${NavbarView}
            ${HomeView}
        `;
    }
}