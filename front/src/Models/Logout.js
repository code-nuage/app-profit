import Config from "../config.js"

import NotificationController from "../Controllers/Notification";

export default async function() {
    try {
        const response = await fetch(`${Config.BACKEND_URL}:${Config.BACKEND_PORT}/logout`, {
            method: 'POST',
            credentials: 'include'
        });

        const result = await response.json();

        if (response.ok) {
            console.log(result);
            new NotificationController("Connection", "Vous êtes déconnecté.", "accent");
        } else {
            new NotificationController("Error", result.error, "negative");
        }
    } catch(error) {
        new NotificationController("Server Error", "Can't connect to the backend server", "negative");
    }
}