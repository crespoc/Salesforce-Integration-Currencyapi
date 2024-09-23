/*
public class CurrencyConverter {
    private static final String API_URL = 'https://api.currencyapi.com/v3/latest?apikey=cur_live_VegVGtt5thgXFz2spv6oELgbsBpBNHCaqEEHks7M';

    public void getCurrencyRates() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(API_URL);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                // Maneja la respuesta JSON
                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                // Aquí puedes trabajar con los datos recibidos
                System.debug(result);
            } else {
                System.debug('Error en la llamada: ' + response.getStatus());
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
}
*/

/*
public class CurrencyConverter {
    private static final String API_URL = 'https://api.currencyapi.com/v3/latest?apikey=cur_live_VegVGtt5thgXFz2spv6oELgbsBpBNHCaqEEHks7M';

    public void getCurrencyRates() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(API_URL);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                // Maneja la respuesta JSON
                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                Map<String, Object> data = (Map<String, Object>) result.get('data');
                
                // Cast del 'meta' para acceder al valor 'last_updated_at'
                Map<String, Object> meta = (Map<String, Object>) result.get('meta');
                String lastUpdated = (String) meta.get('last_updated_at');

                List<CurrencyRate__c> ratesToInsert = new List<CurrencyRate__c>();

                for (String currencyCode : data.keySet()) {
                    Map<String, Object> currencyData = (Map<String, Object>) data.get(currencyCode);
                    CurrencyRate__c rate = new CurrencyRate__c();
                    rate.Currency_Code__c = (String) currencyData.get('code');
                    rate.Value__c = (Decimal) currencyData.get('value');
                    //rate.Last_Updated_At__c = DateTime.valueOf(lastUpdated);
                    rate.Last_Updated_At__c = DateTime.valueOf(lastUpdated.replace('T', ' ').replace('Z', ''));
                    ratesToInsert.add(rate);
                }

                // Insertar los registros en Salesforce
                insert ratesToInsert;

            } else {
                System.debug('Error en la llamada: ' + response.getStatus());
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
}
*/


public class CurrencyConverter {
    private static final String API_URL = 'https://api.currencyapi.com/v3/latest?apikey=cur_live_VegVGtt5thgXFz2spv6oELgbsBpBNHCaqEEHks7M';

    public void getCurrencyRates() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(API_URL);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                // Se Maneja la respuesta JSON
                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                Map<String, Object> data = (Map<String, Object>) result.get('data');
                
                // Cast del 'meta' para acceder al valor 'last_updated_at'
                Map<String, Object> meta = (Map<String, Object>) result.get('meta');
                String lastUpdated = (String) meta.get('last_updated_at');

                List<CurrencyRate__c> ratesToUpsert = new List<CurrencyRate__c>();

                for (String currencyCode : data.keySet()) {
                    Map<String, Object> currencyData = (Map<String, Object>) data.get(currencyCode);
                    CurrencyRate__c rate = new CurrencyRate__c();
                    rate.Currency_Code__c = (String) currencyData.get('code');
                    rate.Value__c = (Decimal) currencyData.get('value');
                    //rate.Last_Updated_At__c = DateTime.valueOf(lastUpdated);
                    rate.Last_Updated_At__c = DateTime.valueOf(lastUpdated.replace('T', ' ').replace('Z', ''));
                    ratesToUpsert.add(rate);
                }

                // Realizar upsert
                //'Currency_Code__c' es un campo único
                upsert ratesToUpsert Currency_Code__c;

            } else {
                System.debug('Error en la llamada: ' + response.getStatus());
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
}
