let home_contents = document.querySelectorAll('.home_contents');
let history_content = document.querySelector('.history_content');
let recommended_content = document.querySelector('.recommended_content');
let history_trigger = document.querySelector('.history_trigger');
let recommended_trigger = document.querySelector('.recommended_trigger');

function toggleActiveTab() {
    history_content.classList.toggle("show_tab");
    recommended_content.classList.toggle("show_tab");
    history_trigger.classList.toggle('active');
    recommended_trigger.classList.toggle('active');
}

history_trigger.addEventListener("click", toggleActiveTab);
recommended_trigger.addEventListener("click", toggleActiveTab);
