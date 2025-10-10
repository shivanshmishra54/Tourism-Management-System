document.addEventListener('DOMContentLoaded', () => {
    const searchBar = document.getElementById('search-bar');
    const packageCards = document.querySelectorAll('.package-card');

    searchBar.addEventListener('input', (e) => {
        const searchTerm = e.target.value.toLowerCase();

        packageCards.forEach(card => {
            const packageName = card.querySelector('h3').textContent.toLowerCase();
            const packageDescription = card.querySelector('p').textContent.toLowerCase();

            // Agar search term, package ke naam ya description mein milta hai to card dikhao
            if (packageName.includes(searchTerm) || packageDescription.includes(searchTerm)) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    });
});