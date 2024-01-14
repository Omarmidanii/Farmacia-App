importScripts("https://www.gstatic.com/firebasejs/9.9.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/9.9.0/firebase-messaging.js");


const firebaseConfig = {
  apiKey: "AIzaSyCIQSmForTJU5TOA_f3wKCJGQcTBCuPii8",
  authDomain: "farmacia-2e933.firebaseapp.com",
  projectId: "farmacia-2e933",
  storageBucket: "farmacia-2e933.appspot.com",
  messagingSenderId: "255236830445",
  appId: "1:255236830445:web:a5baf90cc40521d9b3c8e4"
};

// Initialize Firebase
firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});