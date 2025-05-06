import Config from "../config.js"

import NotificationController from "../Controllers/Notification";

export default async function() {
    try {
        const response = await fetch(`${Config.BACKEND_URL}:${Config.BACKEND_PORT}/me`, {
            method: 'GET',
            credentials: 'include'
        });

        const result = await response.json();

        if (response.ok) {
            return true;
        } else {
            new NotificationController("Error", result.error, "negative");
            return false;
        }
    } catch(error) {
        new NotificationController("Server Error", "Can't connect to the backend server", "negative");
        return false;
    }
}
