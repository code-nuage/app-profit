import WhiteNoiseView from '../Views/WhiteNoise.js';
import NavbarView from '../Views/Navbar.js';
import Error404View from '../Views/Error404.js';

export default class Error404Controller {
    constructor() {
        this.app = document.querySelector('#app');
        this.run();
    }

    run() {
        this.render();
    }

    render() {
        this.app.innerHTML += `
            ${WhiteNoiseView}
            ${NavbarView}
            ${Error404View}
        `;
    }
}