let modal = document.querySelector(".modal_container");
let modalBackground = document.querySelector(".modal_background");
let modal_trigger = document.querySelector(".modal_trigger");
let closeButton = document.querySelector(".close_button");

function toggleModal() {
    modal.classList.toggle("show_modal");
    modalBackground.classList.toggle("show_modal");
}

function windowOnClick(event) {
    if (event.target === modal) {
        toggleModal();
    }
}

modal_trigger.addEventListener("click", toggleModal);
closeButton.addEventListener("click", toggleModal);
window.addEventListener("click", windowOnClick);
