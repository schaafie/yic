const template = document.createElement('template');
template.innerHTML = `<style>
:host {
    color: #333333;
    font: 16px Arial, sans-serif;
}

p { margin: 0; }

p.second { margin-top: 20px; }

a { color: #1f66e5; }

label { 
    display: block; 
    margin-bottom: 10px;
    font-size: 16pt;
}

.error {
    display: block; 
    color: red;
    font-style: italic;
    margin-bottom: 15px;    
}

span {
    background-color: #eaeaea;
    border: 1px solid grey;
    border-radius: 4px;
    box-sizing: border-box;
    color: inherit;
    font: inherit;
    padding: 10px 10px;
    width: 100px;
}

.dropbtn {
    font: 16px/1.6 Arial, sans-serif;
    color: white;
    background: #3e8e41;
    border: 1px solid #1f66e5;
    border-radius: 4px;
    padding: 5px 15px
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {background-color: #ddd;}
.dropdown:hover .dropdown-content {display: block;}
.dropdown:hover .dropbtn {background-color: #6b6;}

.input { margin-bottom: 15px; }

</style>
<p>
    <label></label>
    <div class="input">
        <span id="version_code">0.0.0</span>
        <div class="dropdown">
            <button class="dropbtn">&#8681 &nbsp; Select</button>
            <div class="dropdown-content">
                <a href="#" id="major">Major</a>
                <a href="#" id="medior">Medior</a>
                <a href="#" id="minor">Minor</a>
            </div>
        </div>
    </div>
    <div class="errors"></div>
</p>
`;

export default class YicFormVersionInput extends HTMLElement {
    
    constructor() {
        super();
        this.minor  = -1;
        this.medior = -1;
        this.major  = -1;
        this.org_minor  = -1;
        this.org_medior = -1;
        this.org_major  = -1;

        this._shadowRoot = this.attachShadow({ 'mode': 'open' });
        this._shadowRoot.appendChild(template.content.cloneNode(true));

        this.$major = this._shadowRoot.querySelector('#major');
        this.$major.addEventListener('click', this.handleChange.bind(this));
        this.$medior = this._shadowRoot.querySelector('#medior');
        this.$medior.addEventListener('click', this.handleChange.bind(this));
        this.$minor = this._shadowRoot.querySelector('#minor');
        this.$minor.addEventListener('click', this.handleChange.bind(this));
        this.$version = this._shadowRoot.querySelector('#version_code');
        this.$errors = this._shadowRoot.querySelector('.errors');
        this.errors = [];
    }

    connectedCallback() {}

    handleChange( event ) {
        if (!this.is_original()) this.reset(); 
        switch(event.target.id) {
            case "minor":
                this.setAttribute("minor", 1 + Number(this.minor));
                break;
            case "medior":
                this.setAttribute("medior", 1 + Number(this.medior));
                this.setAttribute("minor", 0);
                break;
            case "major":
                this.setAttribute("major", 1 + Number(this.major));
                this.setAttribute("medior", 0);
                this.setAttribute("minor", 0);
                break;
        }
    }

    is_original() {
        return (this.major==this.org_major && this.medior==this.org_medior && this.minor==this.org_minor);
    }

    reset() {
        this.setAttribute("minor", this.org_minor);
        this.setAttribute("medior", this.org_medior);
        this.setAttribute("major", this.org_major);
    }

    refreshErrors() {
        this.$errors.innerHTML = "";
        this.errors.forEach( error => {
            var errSpan = document.createElement('div');
            errSpan.className = 'error';
            errSpan.innerHTML = error;
            this.$errors.appendChild(errSpan);
        });  
    }

    update_version() {
        this.$version.innerHTML = `${this.major}.${this.medior}.${this.minor}`;
    }

    static get observedAttributes() { 
        return ['minor', 'medior', 'major', 'label', 'name'];
    }

    attributeChangedCallback(name, oldValue, newValue) {
        let value=0;
        switch(name) {
            case 'name':
                if (this.$field.getAttribute('name') != newValue) {
                    this.name = newValue;
                    this.$field.setAttribute( 'name', newValue);
                }
                break;
            case 'label':
                if (this._shadowRoot.querySelector('label').innerHTML != newValue) {
                    this._shadowRoot.querySelector('label').innerHTML = newValue;
                }
                break;
            case 'minor':
                value = Number( newValue );
                if (this.minor != value) {
                    if (this.org_minor==-1) this.org_minor = value;
                    this.minor = value;
                    this.dispatchEvent(new CustomEvent('change',{ detail: {minor: value}, bubbles: false }));
                    this.update_version();
                }
                break;
            case 'medior':
                value = Number( newValue );
                if (this.medior != value) {
                    if (this.org_medior==-1) this.org_medior = value;
                    this.medior = value;
                    this.dispatchEvent(new CustomEvent('change',{ detail: {medior: value}, bubbles: false }));
                    this.update_version();
                }
                break;
            case 'major':
                value = Number( newValue );
                if (this.value != value) {
                    if (this.org_major==-1) this.org_major = value;
                    this.major = value;
                    this.dispatchEvent(new CustomEvent('change',{ detail: {major: value}, bubbles: false }));
                    this.update_version();
                }
                break;
        }
    }
}

window.customElements.define('yic-form-version-input', YicFormVersionInput);