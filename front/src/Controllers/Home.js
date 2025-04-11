import NavbarView from '../Views/Navbar.js';
import HomeView from '../Views/Home.js';

import '../Styles/home.css';

export default class HomeController {
    constructor() {
        this.app = document.querySelector('#app');
    }

    render() {
        this.app.innerHTML = `
            ${NavbarView}
            ${HomeView}
        `;
    }
}