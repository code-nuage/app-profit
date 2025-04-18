import ControllerError404 from './Controllers/Error404';

const Router = class Router {
  constructor(routes = []) {
    this.path = window.location.pathname;
    this.routes = routes;
    this.params = !window.location.search ? {} : Object.fromEntries(
      window.location.search
        .split('?')[1]
        .split('&')
        .map((param) => param.split('='))
    );

    this.run();
  }

  startController() {
    for (let i = 0; i < this.routes.length; i += 1) {
      const route = this.routes[i];

      if (route.url === this.path) {
        const ControllerPath = route.controller;
        const Controller = new ControllerPath(this.params);
        Controller.render()
        return;
      }
    }
    const Controller = new ControllerError404();
    Controller.render()
  }

  run() {
    this.startController();
  }
};

export default Router;