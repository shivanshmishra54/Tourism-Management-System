// --- SCRIPT 1: Handle error messages from URL (No changes here) ---
   window.addEventListener('DOMContentLoaded', () => {
       const params = new URLSearchParams(window.location.search);
       const error = params.get('error');
       const errorDiv = document.getElementById('error-message');
       if (error) {
           let message = 'An error occurred.';
           if (error === 'username_taken') {
               message = 'That username is already taken. Please choose another one.';
           }
           errorDiv.textContent = message;
           errorDiv.style.display = 'block';
       }
   });

   // --- SCRIPT 2: Real-time username validation with Debounce (UPDATED) ---
   const usernameInput = document.getElementById('username');
   const statusSpan = document.getElementById('username-status');
   let debounceTimer; // Timer for the delay

   // The event is now 'input', which fires on every keystroke
   usernameInput.addEventListener('input', function() {
       const username = this.value.trim();

       // Clear any previous timer
       clearTimeout(debounceTimer);
       statusSpan.textContent = ''; // Immediately clear the status

       if (username.length < 4) {
           if (username.length > 0) {
               statusSpan.textContent = 'Username must be at least 4 characters.';
               statusSpan.style.color = 'red';
           }
           return;
       }

       // Set a new timer. The check will only run after 500ms of inactivity.
       debounceTimer = setTimeout(() => {
           fetch('CheckUsernameServlet', {
               method: 'POST',
               headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
               body: 'username=' + encodeURIComponent(username)
           })
           .then(response => response.json())
           .then(data => {
               if (data.exists) {
                   statusSpan.textContent = 'Username is already taken!';
                   statusSpan.style.color = 'red';
               } else {
                   statusSpan.textContent = 'Username is available!';
                   statusSpan.style.color = 'green';
               }
           })
           .catch(error => console.error('Error:', error));
       }, 500); // 500 milliseconds (half a second) delay
   });