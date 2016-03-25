package id.co.akhdani.smartqueue.engine.master;

import labs.akhdani.alt.AltDbo;
import labs.akhdani.alt.AltHttpRequest;

public class MasterType extends AltDbo {

    public MasterType(){
        this(null);
    }

    public MasterType(AltHttpRequest request){
        super(request);

        this.pkey           = "typeid";
        this.table_name     = "master_type";
        this.table_fields.put("typeid", "");
        this.table_fields.put("name", "");
        this.table_fields.put("description", "");
    }
}