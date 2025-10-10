document.addEventListener('DOMContentLoaded', () => {
    
    // Function to animate the numbers
    const animateNumbers = (id, target) => {
        const element = document.getElementById(id);
        if (!element) return; 

        let current = 0;
        const duration = 2000; // 2 seconds animation
        // We'll increment the number slightly based on the total steps and duration
        const increment = target / (duration / 10); 

        const timer = setInterval(() => {
            current += increment;
            if (current >= target) {
                current = target;
                clearInterval(timer);
            }
            // Display the rounded-down number
            element.textContent = Math.floor(current).toLocaleString(); // Add toLocaleString for comma separation
        }, 10); 
    };

    // Intersection Observer to trigger animation when section comes into view
    const statsSection = document.querySelector('.stats-section');
    
    // Observer settings
    const observerOptions = {
        root: null, // relative to the viewport
        rootMargin: '0px',
        threshold: 0.5 // Trigger when 50% of the section is visible
    };

    // Observer callback function
    const observer = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                // Dummy/Placeholder Numbers (You can later replace these with data from your database)
                animateNumbers('places-count', 150);
                animateNumbers('tourist-count', 50000); // 50,000 travelers
                animateNumbers('packages-count', 200);
                
                observer.unobserve(entry.target); // Stop observing once animated
            }
        });
    }, observerOptions);

    // Start observing
    if (statsSection) {
        observer.observe(statsSection);
    }
});