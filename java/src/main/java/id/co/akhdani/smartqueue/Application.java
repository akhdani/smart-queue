package id.co.akhdani.smartqueue;

import labs.akhdani.Alt;
import spark.servlet.SparkApplication;

import static spark.Spark.webSocket;

public class Application implements SparkApplication {
    public static final String TAG = Application.class.getName();

    @Override
    public void init() {
        // create alt server application
        Alt server = Alt.instance(Application.class);

        // define websocket
        webSocket("/realtime", Websocket.class);

        // start server
        server.start();
    }

    public static void main(String[] args) {
        Application app = new Application();
        app.init();
    }
}