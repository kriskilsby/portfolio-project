// document.addEventListener("DOMContentLoaded", function () {

//     function loadComponent(id, file, isHead = false, callback = null) {
//         fetch(file)
//             .then(response => response.text())
//             .then(data => {
//                 if (isHead) {
//                     const temp = document.createElement('div');
//                     temp.innerHTML = data;
//                     const headContent = temp.querySelectorAll('link, script');
//                     headContent.forEach(el => document.head.appendChild(el.cloneNode(true)));
//                 } else {
//                     let element = document.getElementById(id);
//                     if (element) {
//                         element.outerHTML = data;
//                         if (callback) callback();
//                     }
//                 }
//             })
//             .catch(error => console.error(`Error loading ${file}:`, error));
//     }

//     // Set Bootstrap layout
//     document.body.classList.add("d-flex", "flex-column", "min-vh-100");

//     // Dynamically Load head content
//     loadComponent(null, 'components/head.html', true);

//     // Load navbar and toggle logic
//     loadComponent('navbar', 'components/navbar.html', false, function () {
//         // Navbar toggle
//         const navbarToggler = document.querySelector(".navbar-toggler");
//         if (navbarToggler) {
//             navbarToggler.addEventListener("click", function () {
//                 const navbarCollapse = document.querySelector("#navbarNav");
//                 if (navbarCollapse) navbarCollapse.classList.toggle("show");
//             });
//         }

//         // Highlight active nav link
//         const currentPath = window.location.pathname.toLowerCase();
//         const navLinks = document.querySelectorAll(".navbar-nav .nav-link, .dropdown-menu .dropdown-item");

//         navLinks.forEach(link => {
//             const href = link.getAttribute("href").toLowerCase();

//             const isFacilitiesSubpage =
//                 ["restaurant", "bar", "gym", "conference"].some(p =>
//                     currentPath.includes(`/crown-hotel/${p}`)
//                 );

//             if (
//                 currentPath.endsWith(href) ||
//                 currentPath.includes(`/crown-hotel/${href}`)
//             ) {
//                 link.classList.add("active");
//             }

//             // Facilities dropdown parent
//             if (isFacilitiesSubpage && link.getAttribute("href") === "facilities") {
//                 link.classList.add("active");
//             }
//         });

//         // =================== STOP API THROTTLING WEATHER APP ON EVERY PAGE LOAD ============
//         const weatherDiv = document.getElementById('weather-info');
//         if (weatherDiv) {
//             fetch('/crown-hotel/api/weather')
//                 .then(response => response.json())
//                 .then(data => {
//                     if (!data || !data.weather || !data.weather[0]) {
//                         console.warn('Weather data missing or malformed', data);
//                         return;
//                     }

//                     const iconCode = data.weather[0].icon;
//                     const temp = Math.round(data.main.temp);
//                     const iconUrl = `https://openweathermap.org/img/wn/${iconCode}@2x.png`;
//                     const description = data.weather[0].description;

//                     weatherDiv.innerHTML = `
//                         <a href="https://www.bbc.co.uk/weather/2641181" target="_blank" rel="noopener noreferrer"
//                         class="d-flex align-items-center text-decoration-none text-muted"
//                         title="View full forecast on BBC Weather">
//                             <img src="${iconUrl}" alt="${description}" width="24" height="24">
//                             <span class="ms-1">${temp}°C</span>
//                         </a>
//                     `;
//                 })
//                 .catch(err => console.error('Error fetching weather:', err));
//         }

//     });

//     // Load footer
//     loadComponent('footer', 'components/footer.html');

//     //Bootstrap Modal JavaScript - to allow the opening of the images following a click
//     const imageModal = document.getElementById('imageModal');
//     if (imageModal) {
//         imageModal.addEventListener('show.bs.modal', function (event) {
//             const trigger = event.relatedTarget;
//             if (!trigger) return;

//             const image = trigger.querySelector('img');
//             const modalImage = imageModal.querySelector('#modalImage');
//             const modalTitle = imageModal.querySelector('#imageModalLabel');

//             if (image && modalImage) {
//                 modalImage.src = image.src;
//                 modalImage.alt = image.alt || '';
//             }

//             const title = trigger.getAttribute('data-bs-title');
//             if (title && modalTitle) {
//                 modalTitle.textContent = title;
//             }
//         });
//     }

//     // After navbar, footer, and head are loaded
//     const body = document.body;
//     body.classList.remove("d-none"); // make it visible

// });

// #####################################################

// ####### TRY THIS TO CHECK IT WORKS ##################

// #####################################################

document.addEventListener("DOMContentLoaded", async function () {
  async function loadComponent(id, file, isHead = false) {
    try {
      const response = await fetch(file);
      const data = await response.text();

      if (isHead) {
        const temp = document.createElement("div");
        temp.innerHTML = data;
        const headContent = temp.querySelectorAll("link, script");
        headContent.forEach((el) =>
          document.head.appendChild(el.cloneNode(true))
        );
      } else if (id) {
        const element = document.getElementById(id);
        if (element) {
          element.outerHTML = data;
        } else {
          console.error(`Element #${id} not found!`);
        }
      }
    } catch (error) {
      console.error(`Error loading ${file}:`, error);
    }
  }

  async function loadWeather() {
    const weatherDiv = document.getElementById("weather-info");
    if (!weatherDiv) return;

    try {
      const response = await fetch("/crown-hotel/api/weather");
      // const response = await fetch('/api/weather');

      const data = await response.json();

      if (!data || !data.weather || !data.weather[0]) {
        console.warn("Weather data missing or malformed", data);
        return;
      }

      const iconCode = data.weather[0].icon;
      const temp = Math.round(data.main.temp);
      const iconUrl = `https://openweathermap.org/img/wn/${iconCode}@2x.png`;
      const description = data.weather[0].description;

      weatherDiv.innerHTML = `
                <a href="https://www.bbc.co.uk/weather/2641181" target="_blank" rel="noopener noreferrer"
                class="d-flex align-items-center text-decoration-none text-muted"
                title="View full forecast on BBC Weather">
                    <img src="${iconUrl}" alt="${description}" width="24" height="24">
                    <span class="ms-1">${temp}°C</span>
                </a>
            `;
    } catch (err) {
      console.error("Error fetching weather:", err);
    }
  }

  function setupNavbar() {
    const navbarToggler = document.querySelector(".navbar-toggler");
    if (navbarToggler) {
      navbarToggler.addEventListener("click", () => {
        const navbarCollapse = document.querySelector("#navbarNav");
        if (navbarCollapse) navbarCollapse.classList.toggle("show");
      });
    }

    const currentPath = window.location.pathname.toLowerCase();
    const navLinks = document.querySelectorAll(
      ".navbar-nav .nav-link, .dropdown-menu .dropdown-item"
    );
    navLinks.forEach((link) => {
      const href = link.getAttribute("href").toLowerCase();
      const isFacilitiesSubpage = [
        "restaurant",
        "bar",
        "gym",
        "conference",
      ].some((p) => currentPath.includes(`/crown-hotel/${p}`));
      // const isFacilitiesSubpage = ["restaurant", "bar", "gym", "conference"].some(p =>
      //     currentPath.includes(`/${p}`)
      // );

      if (
        currentPath.endsWith(href) ||
        currentPath.includes(`/crown-hotel/${href}`)
      ) {
        link.classList.add("active");
      }
      // if (currentPath.endsWith(href) || currentPath.includes(`/${href}`)) {
      //     link.classList.add("active");
      // }

      if (isFacilitiesSubpage && link.getAttribute("href") === "facilities") {
        link.classList.add("active");
      }
    });
  }

  function setupModals() {
    const imageModal = document.getElementById("imageModal");
    if (!imageModal) return;

    imageModal.addEventListener("show.bs.modal", function (event) {
      const trigger = event.relatedTarget;
      if (!trigger) return;

      const image = trigger.querySelector("img");
      const modalImage = imageModal.querySelector("#modalImage");
      const modalTitle = imageModal.querySelector("#imageModalLabel");

      if (image && modalImage) {
        modalImage.src = image.src;
        modalImage.alt = image.alt || "";
      }

      const title = trigger.getAttribute("data-bs-title");
      if (title && modalTitle) {
        modalTitle.textContent = title;
      }
    });
  }

  // Prevent FOUC
  document.body.classList.add("d-none");
  document.body.classList.add("d-flex", "flex-column", "min-vh-100");

  // Load all components sequentially
  // await loadComponent(null, 'components/head.html', true);
  // await loadComponent('navbar', 'components/navbar.html');
  setupNavbar();

  // await loadComponent('footer', 'components/footer.html');
  await loadWeather();
  setupModals();

  // All done → show the body
  document.body.classList.remove("d-none");
});
