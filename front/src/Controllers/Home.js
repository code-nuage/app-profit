import NavbarView from '../Views/Navbar.js';
import HomeView from '../Views/Home.js';

import WhiteNoise from '../Assets/white-noise.png';
import Icon from '../Assets/icon.png';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
    }

    render() {
        this.app.innerHTML = `
            ${NavbarView}
            ${HomeView}
        `.replace("{{Icon}}", Icon)
        .replace("{{WhiteNoise}}", WhiteNoise);
    }
}