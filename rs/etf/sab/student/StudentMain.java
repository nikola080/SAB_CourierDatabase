package rs.etf.sab.student;



import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import rs.etf.sab.operations.*;
import rs.etf.sab.tests.TestHandler;
import rs.etf.sab.tests.TestRunner;


public class StudentMain {

    public static void main(String[] args) {
        
        AddressOperations addressOperations = new ImpAddressOperations(); 
        CityOperations cityOperations = new ImpCityOperations(); 
        CourierOperations courierOperations = new ImpCourierOperations(); 
        CourierRequestOperation courierRequestOperation = new ImpCourierRequestOperation();
        DriveOperation driveOperation = new ImpDriveOperations();
        GeneralOperations generalOperations = new ImpGeneralOperations();
        PackageOperations packageOperations = new ImpPackageOperations();
        StockroomOperations stockroomOperations = new ImpStockroomOperations();
        UserOperations userOperations = new ImpUserOperations();
        VehicleOperations vehicleOperations = new ImpVehicleOperations();
        
        
       
        TestHandler.createInstance(
                addressOperations,
                cityOperations,
                courierOperations,
                courierRequestOperation,
                driveOperation,
                generalOperations,
                packageOperations,
                stockroomOperations,
                userOperations,
                vehicleOperations);

        TestRunner.runTests();
        
    }
}
