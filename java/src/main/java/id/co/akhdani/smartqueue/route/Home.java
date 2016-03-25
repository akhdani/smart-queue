package id.co.akhdani.smartqueue.route;

import labs.akhdani.alt.AltHttpRequest;
import labs.akhdani.alt.AltHttpResponse;

public class Home {
    public static final String TAG = Home.class.getName();

    public String index(AltHttpRequest req, AltHttpResponse res){
        return "Smart Queue Server is RUNNING!";
    }
}