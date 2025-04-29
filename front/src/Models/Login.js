import Config from "../config.js"

import NotificationController from "../Controllers/Notification";

export default async function(controller) {
    const email = document.querySelector('#email').value;
    const password = document.querySelector('#password').value;

    const data = { email, password };

    try {
        const response = await fetch(`${Config.BACKEND_URL}:${Config.BACKEND_PORT}/login`, {
            method: 'POST',
            credentials: 'include',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

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

    controller.attachForm();                                                   // Reattach the form since form reloads on post (??)
}