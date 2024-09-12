// Define the URL of your API
const apiUrl = 'https://ppf34enmbe.execute-api.us-east-2.amazonaws.com/prod/visits';

// Function to fetch data from the API and update the webpage
async function fetchAndDisplayVisitCount() {
    try {
        // Fetch data from the API using POST method
        const response = await fetch(apiUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                // Include any additional headers required by your API here
                // e.g., 'x-api-key': 'YOUR_API_KEY' if an API key is needed
            },
            // If your POST request needs a body, include it here
            // body: JSON.stringify({ key: 'value' })
        });
        
        // Check if the response is OK (status code 200-299)
        if (!response.ok) {
            throw new Error('Network response was not ok.');
        }

        // Parse the JSON data
        const data = await response.json();

        // Extract the message from the JSON data
        const message = data.message;

        // Update the HTML element with the visit count message
        document.getElementById('visit-counter').textContent = message;

    } catch (error) {
        // Handle any errors that occurred during the fetch
        console.error('There was a problem with the fetch operation:', error);
        document.getElementById('visit-counter').textContent = 'Error fetching visit count.';
    }
}

// Call the function when the page loads
window.onload = fetchAndDisplayVisitCount;
