customElements.define('intl-image',
    class extends HTMLElement {
        // things required by Custom Elements
        img;
        constructor() {
            super();
            var shadow = this.attachShadow({mode: 'open'});
            this.img = document.createElement('img');
            shadow.appendChild(this.img)
        }

        connectedCallback() { this.setContent(); }
        attributeChangedCallback() { this.setContent(); }
        static get observedAttributes() { return ['width','height','src', 'defaultSrc']; }

        // Our function to set the textContent based on attributes.
        setContent()
        {
            this.img.src = this.getAttribute("src");
            let defaultSrc = this.getAttribute("defaultSrc")
            this.img.onerror = function () {this.onerror=null;this.src=defaultSrc};
            this.img.width = Math.floor(this.getAttribute("width"));
            this.img.height = Math.floor(this.getAttribute("height"));
        }
    }
);