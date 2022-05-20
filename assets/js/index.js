import { buttonColourMode } from 'js/button-toggle-colour-mode';
import { addAnchors } from 'js/add-anchors';

const load = () => {
  buttonColourMode()
  addAnchors();
};

document.addEventListener('DOMContentLoaded', function(event) {
  addAnchors();
});

window.onload = load;
