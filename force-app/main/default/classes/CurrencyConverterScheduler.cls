global class CurrencyConverterScheduler implements Schedulable {
    
    global void execute(SchedulableContext sc) {
        // Llamar al método que deseas ejecutar
        CurrencyConverter currencyConverter = new CurrencyConverter();
        currencyConverter.getCurrencyRates();
    }
}
