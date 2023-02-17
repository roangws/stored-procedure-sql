
USE H_Accounting;


DROP PROCEDURE IF EXISTS `H_Accounting.sp_stirpude`;

-- The typical delimiter for Stored procedures is a double dollar sign
DELIMITER $$

	CREATE PROCEDURE `H_Accounting.sp_stirpude` (varCalendarYear smallint)
    READS SQL DATA
	BEGIN
  
	-- Define variables inside procedure. Delclare previous year varibles for every section like for gross profit we have gross profit and previous year gross profit because the template in the modules shows a year and previous year next to it.
    DECLARE Revenue_9			DOUBLE DEFAULT 0;
    DECLARE RevenuePrevious_9     DOUBLE DEFAULT 0;
    DECLARE ReturnsRefundsDiscounts_9 			DOUBLE DEFAULT 0;
    DECLARE ReturnsRefundsDiscountsPrevious_9		 DOUBLE DEFAULT 0;
    DECLARE COGS_9 			DOUBLE DEFAULT 0;
    DECLARE COGSPrevious_9 			DOUBLE DEFAULT 0;
    DECLARE GrossProfit_9 		DOUBLE DEFAULT 0;
    DECLARE GrossProfitPrevious_9 		DOUBLE DEFAULT 0;
	DECLARE AdminExp_9 		DOUBLE DEFAULT 0;
    DECLARE AdminExpPrevious_9 		DOUBLE DEFAULT 0;
    DECLARE SellingExp_9		DOUBLE DEFAULT 0;
    DECLARE SellingExpPrevious_9		DOUBLE DEFAULT 0;
    DECLARE OtherExp_9			DOUBLE DEFAULT 0;
    DECLARE OtherExpPrevious_9			DOUBLE DEFAULT 0;
    DECLARE OtherIncome_9		DOUBLE DEFAULT 0;
    DECLARE OtherIncomePrevious_9		DOUBLE DEFAULT 0;
    DECLARE EBIT_9				DOUBLE DEFAULT 0;
    DECLARE EBITPrevious_9				DOUBLE DEFAULT 0;
    DECLARE IncomeTax_9		DOUBLE DEFAULT 0;
    DECLARE IncomeTaxPrevious_9		DOUBLE DEFAULT 0;
	DECLARE OtherTax_9			DOUBLE DEFAULT 0;
    DECLARE OtherTaxPrevious_9			DOUBLE DEFAULT 0;
	DECLARE ProfitLoss_9		DOUBLE DEFAULT 0;
    DECLARE ProfitLossPrevious_9		DOUBLE DEFAULT 0;
	DECLARE CurrentAssets_9 			DOUBLE DEFAULT 0;
    DECLARE CurrentAssetsPrevious_9 			DOUBLE DEFAULT 0;
    DECLARE FixedAssets_9 			DOUBLE DEFAULT 0;
    DECLARE FixedAssetsPrevious_9 			DOUBLE DEFAULT 0;
    DECLARE DeferredAssets_9 			DOUBLE DEFAULT 0;
    DECLARE DeferredAssetsPrevious_9 			DOUBLE DEFAULT 0;
    DECLARE CurrentLiab_9				DOUBLE DEFAULT 0;
	DECLARE CurrentLiabPrevious_9				DOUBLE DEFAULT 0;
    DECLARE LongTermLiab_9 			DOUBLE DEFAULT 0;
    DECLARE LongTermLiabPrevious_9 			DOUBLE DEFAULT 0;
    DECLARE DeferredLiab_9 			DOUBLE DEFAULT 0;
	DECLARE DeferredLiabPrevious_9 			DOUBLE DEFAULT 0;
    DECLARE Equity_9				DOUBLE DEFAULT 0;
    DECLARE EquityPrevious_9				DOUBLE DEFAULT 0;
    DECLARE TotalAsset_9		DOUBLE DEFAULT 0;
    DECLARE TotalAssetPrevious_9		DOUBLE DEFAULT 0;
    DECLARE TotalLiabi_9		DOUBLE DEFAULT 0;
    DECLARE TotalLiabiPrevious_9		DOUBLE DEFAULT 0;
    DECLARE EquityuLiabi_9		DOUBLE DEFAULT 0;
	DECLARE EquityuLiabiPrevious_9		DOUBLE DEFAULT 0;
    
-- Current year revenue
SELECT 
    SUM(jeli.debit) INTO Revenue_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'REV'
;
-- Previous year revenue            
SELECT 
    SUM(jeli.debit) INTO RevenuePrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'REV'
;
 
 -- Current year Returns, Refunds, Discounts          
SELECT 
    SUM(jeli.debit) INTO ReturnsRefundsDiscounts_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'RET'
;
 
  -- Previous year Returns, Refunds, Discounts          
SELECT 
    SUM(jeli.debit) INTO ReturnsRefundsDiscountsPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'RET'
;
            
 -- Current year Cost of Goods and Services        
SELECT 
    SUM(jeli.credit) INTO COGS_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'COGS'
;            
            
 -- Previous year Cost of Goods and Services        
SELECT 
    SUM(jeli.credit) INTO COGSPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'COGS'
;   
            
 -- Current year GrossProfit        
SELECT 
    SUM(jeli.credit) INTO GrossProfit_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code IN ('REV' , 'RET', 'COGS')
;    
            
 -- Previous year GrossProfit        
SELECT 
    SUM(jeli.credit) INTO GrossProfitPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code IN ('REV' , 'RET', 'COGS')
;                     
            
-- Current year Administrative Expenses        
SELECT 
    SUM(jeli.credit) INTO AdminExp_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'GEXP'
;                      
 
 -- Previous year Administrative Expenses        
SELECT 
    SUM(jeli.credit) INTO AdminExpPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'GEXP'
;    
            
  -- Current year Selling Expenses        
SELECT 
    SUM(jeli.credit) INTO SellingExp_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'SEXP'
;        
  -- Previous year Selling Expenses        
SELECT 
    SUM(jeli.credit) INTO SellingExpPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'SEXP'
;   
  -- Current year Other Expenses        
SELECT 
    SUM(jeli.credit) INTO OtherExp_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'OEXP'
;        
  -- Previous year Other Expenses        
SELECT 
    SUM(jeli.credit) INTO OtherExpPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'OEXP'
;   
  -- Current year Selling Expenses        
SELECT 
    SUM(jeli.credit) INTO SellingExp_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'SEXP'
;        
  -- Previous year Selling Expenses        
SELECT 
    SUM(jeli.credit) INTO SellingExpPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'SEXP'
;   
  -- Current year Other Income        
SELECT 
    SUM(jeli.debit) INTO OtherIncome_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'OI'
;        
  -- Previous year Other Income        
SELECT 
    SUM(jeli.debit) INTO OtherIncomePrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'OI'
;               

  -- Current year EBIT        
SELECT 
    SUM(jeli.debit) INTO EBIT_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code IN ('REV','RET', 'COGS','GEXP','SEXP','OEXP','OI')
;        
  -- Previous year EBIT        
SELECT 
    SUM(jeli.debit) INTO EBITPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code IN ('REV','RET', 'COGS','GEXP','SEXP','OEXP','OI')
; 
  -- Current year Income Tax        
SELECT 
    SUM(jeli.credit) INTO IncomeTax_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'INCTAX'
;        
  -- Previous year Income Tax        
SELECT 
    SUM(jeli.credit) INTO IncomeTaxPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'INCTAX'
; 
  -- Current year Other Tax        
SELECT 
    SUM(jeli.credit) INTO OtherTax_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'OTHTAX'
;        
  -- Previous year Other Tax        
SELECT 
    SUM(jeli.credit) INTO OtherTaxPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'OTHTAX'
;        

  -- Current year Profit loss      
SELECT 
    SUM(jeli.debit) INTO ProfitLoss_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
;        
  -- Previous year Profit Loss        
SELECT 
    SUM(jeli.debit) INTO ProfitLossPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
;   

  -- Current year Current Assets      
SELECT 
    SUM(jeli.debit) -  SUM(jeli.credit) INTO CurrentAssets_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'CA'
        AND je.debit_credit_balanced = 1
;        
  -- Previous year Current Assets       
SELECT 
    SUM(jeli.debit) -  SUM(jeli.credit) INTO CurrentAssetsPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'CA'
        AND je.debit_credit_balanced = 1
;     

  -- Current year Fixed Assets      
SELECT 
    SUM(jeli.debit) -  SUM(jeli.credit) INTO FixedAssets_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'FA'
        AND je.debit_credit_balanced = 1
;        
  -- Previous year Fixed Assets       
SELECT 
    SUM(jeli.debit) -  SUM(jeli.credit) INTO FixedAssetsPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'FA'
        AND je.debit_credit_balanced = 1
;   

  -- Current year Deferred Assets      
SELECT 
    SUM(jeli.debit) -  SUM(jeli.credit) INTO DeferredAssets_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'DA'
        AND je.debit_credit_balanced = 1
;        
  -- Previous year Deferred Assets       
SELECT 
    SUM(jeli.debit) -  SUM(jeli.credit) INTO DeferredAssetsPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'DA'
        AND je.debit_credit_balanced = 1
;   

  -- Current year Current Liabilities      
SELECT 
    SUM(jeli.debit)*-1 +  SUM(jeli.credit) INTO CurrentLiab_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'CL'
        AND je.debit_credit_balanced = 1
;        
  -- Previous year Current Liabilities       
SELECT 
    SUM(jeli.debit)*-1 +  SUM(jeli.credit) INTO CurrentLiabPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'CL'
        AND je.debit_credit_balanced = 1
;  

  -- Current year Long Term Liabilities      
SELECT 
    SUM(jeli.debit)*1 +  SUM(jeli.credit) INTO LongTermLiab_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'LLL'
        AND je.debit_credit_balanced = 1
;        
  -- Previous year Long Term Liabilities       
SELECT 
    SUM(jeli.debit)*1 +  SUM(jeli.credit) INTO LongTermLiabPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'LLL'
        AND je.debit_credit_balanced = 1
;

 -- Current year Deferred Liabilities      
SELECT 
    SUM(jeli.debit)*1 +  SUM(jeli.credit) INTO DeferredLiab_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'DL'
        AND je.debit_credit_balanced = 1
;        
  -- Previous year Deferred Liabilities       
SELECT 
    SUM(jeli.debit)*1 +  SUM(jeli.credit) INTO DeferredLiabPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'DL'
        AND je.debit_credit_balanced = 1
;

 -- Current year Total Liabilities      
SELECT 
    SUM(jeli.debit)*1 +  SUM(jeli.credit) INTO TotalLiabi_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code IN ('CL','LLL','DL')
        AND je.debit_credit_balanced = 1
;        
  -- Previous year Total Liabilities       
SELECT 
    SUM(jeli.debit)*1 +  SUM(jeli.credit) INTO TotalLiabiPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code IN ('CL','LLL','DL')
        AND je.debit_credit_balanced = 1
;

 -- Current year Equity Liabilities      
SELECT 
    SUM(jeli.debit)*1 +  SUM(jeli.credit) INTO EquityuLiabi_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code NOT IN ('CA','FA','DA')
        AND je.debit_credit_balanced = 1
;        
  -- Previous year Equity Liabilities       
SELECT 
    SUM(jeli.debit)*1 +  SUM(jeli.credit) INTO EquityuLiabiPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code NOT IN ('CA','FA','DA')
        AND je.debit_credit_balanced = 1
;
-- Current year Equity
SELECT 
    SUM(jeli.debit) INTO Equity_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2018%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'EQ'
;
-- Previous year Equity            
SELECT 
    SUM(jeli.debit) INTO EquityPrevious_9
FROM
    journal_entry_line_item AS jeli
        INNER JOIN
    `account` AS ac ON ac.account_id = jeli.account_id
        INNER JOIN
    journal_entry AS je ON je.journal_entry_id = jeli.journal_entry_id
        INNER JOIN
    statement_section AS ss ON ss.statement_section_id = ac.profit_loss_section_id
WHERE
    je.entry_date like '%2017%'
        AND ac.profit_loss_section_id IS NOT NULL
        AND ss.statement_section_code = 'EQ'
;
  #create table
DROP TABLE IF EXISTS stirpude_tmp;

	CREATE TABLE stirpude_tmp
		(	Sr_No INT, 
			Title VARCHAR(50), 
			Current_Year VARCHAR(50),
            Previous_Year VARCHAR(50),
            Percentage_Change VARCHAR(50)
		);

	-- Insert statemt will build the first columnt of the PL statement table with column names like revene, gross profit etc, and also fetch values from the existing table to insert into the corresponding column.
	INSERT INTO stirpude_tmp
			(Sr_No, Title, Current_Year, Previous_Year, Percentage_Change)
			VALUES (1, 'Group statemetn of profit and loss', varCalendarYear, varCalendarYear - 1, "In USD"),
				   (2, '', '', " ", " " ),
				   (3, 'Revenue', format(Revenue_9,0), format(RevenuePrevious_9,0), format(((Revenue_9-RevenuePrevious_9)/RevenuePrevious_9)*100,2)),
                   (4, 'Returns, Refunds, Discounts', format(COALESCE(ReturnsRefundsDiscounts_9,0),0),format(COALESCE(ReturnsRefundsDiscountsPrevious_9,0),2), format(((ReturnsRefundsDiscounts_9-ReturnsRefundsDiscountsPrevious_9)/ReturnsRefundsDiscountsPrevious_9)*100,2)),
                   (5, 'Cost of sales', format(COGS_9 	,0),format(COGSPrevious_9,0), " "),
                   (6, 'Gross Profit', format(GrossProfit_9, 0), format(GrossProfitPrevious_9, 0),format(((GrossProfit_9-GrossProfitPrevious_9)/GrossProfitPrevious_9)*100,2)),
                   (7, 'Marketing and Selling Expenses',format(COALESCE(SellingExp_9,0),0), format(COALESCE(SellingExpPrevious_9,0),0), format(((SellingExp_9-SellingExpPrevious_9)/SellingExpPrevious_9)*100,2)),
                   (8, 'Administrative Expenses',format(COALESCE(AdminExp_9,0),0), format(COALESCE(AdminExpPrevious_9,0),0), format(((AdminExp_9-AdminExpPrevious_9)/AdminExpPrevious_9)*100,2)),
                   (9, 'Other Income' , format(COALESCE(OtherIncome_9,0),0), format(COALESCE(OtherIncomePrevious_9,0),0), format(((OtherIncome_9-OtherIncomePrevious_9)/OtherIncomePrevious_9)*100,2)),
                   (10, 'Other Expenses', format(COALESCE(OtherExp_9,0),0), format(COALESCE(OtherExpPrevious_9,0),0), format(((OtherExp_9-OtherExpPrevious_9)/OtherExpPrevious_9)*100,2)),
                   (11, 'Earnings before interest and taxes (EBIT)', format(COALESCE(EBIT_9,0),0), format(COALESCE(EBITPrevious_9,0),0), format(((EBIT_9-EBITPrevious_9)/EBITPrevious_9)*100,2)),
                   (12, 'Income Tax', format(COALESCE(IncomeTax_9,0),0), format(COALESCE(IncomeTaxPrevious_9,0),0), format(((IncomeTax_9-IncomeTaxPrevious_9)/IncomeTaxPrevious_9)*100,2)),
                   (13, 'Other Tax', format(COALESCE(OtherTax_9,0),0), format(COALESCE( OtherTaxPrevious_9,0),0), format(((OtherTax_9-OtherTaxPrevious_9)/OtherTaxPrevious_9)*100,2)),
                   (14, 'Profit for the year', format(COALESCE(ProfitLoss_9,0),0), format(COALESCE(ProfitLossPrevious_9,0),0), format(((ProfitLoss_9-ProfitLossPrevious_9)/ProfitLossPrevious_9)*100,2)),
                   (15, "", "","",""),
                   (16, "", "","",""),
                   (17, 'BALANCE SHEET', varCalendarYear, varCalendarYear - 1, "In USD"),
				   (18, '', '', "", ""),
				   (19, 'Current Assets', format(COALESCE(CurrentAssets_9, 0),0),format(COALESCE(CurrentAssetsPrevious_9, 0),0),format(((CurrentAssets_9-CurrentAssetsPrevious_9)/CurrentAssetsPrevious_9)*100,2)),
                   (20, 'Fixed Assets', format(COALESCE(FixedAssets_9, 0),0),format(COALESCE(FixedAssetsPrevious_9, 0),0),format(((FixedAssets_9-FixedAssetsPrevious_9)/FixedAssetsPrevious_9)*100,2)),
                   (21, 'Deferred Assets', format(COALESCE(DeferredAssets_9, 0),0), format(COALESCE(DeferredAssetsPrevious_9, 0),0),format(((DeferredAssets_9-DeferredAssetsPrevious_9)/DeferredAssetsPrevious_9)*100,2)),
                   (22, 'Total Assets', format(COALESCE(TotalAsset_9, 0),0), format(COALESCE(TotalAssetPrevious_9, 0),0),format(((TotalAsset_9-TotalAssetPrevious_9)/TotalAssetPrevious_9*100),2)),
                   (23, 'Current Liabilities', format(COALESCE(CurrentLiab_9, 0),0), format(COALESCE(CurrentLiabPrevious_9, 0),0),format(((CurrentLiab_9-CurrentLiabPrevious_9)/CurrentLiabPrevious_9)*100,2)),
                   (24, 'Long-term Liabilities', format(COALESCE(LongTermLiab_9, 0),0),  format(COALESCE(LongTermLiabPrevious_9, 0),0),format(((LongTermLiab_9-LongTermLiabPrevious_9)/LongTermLiabPrevious_9)*100,2)),
                   (25, 'Deferred Liabilities' , format(COALESCE(DeferredLiab_9, 0),0),  format(COALESCE(DeferredLiabPrevious_9, 0),0),format(((DeferredLiab_9-DeferredLiabPrevious_9)/DeferredLiabPrevious_9)*100,2)),
                   (26, 'Total Liabilities', format(COALESCE(TotalLiabi_9, 0),0),  format(COALESCE(TotalLiabiPrevious_9, 0),0),format(((TotalLiabi_9-TotalLiabiPrevious_9)/TotalLiabiPrevious_9)*100,2)),
                   (27, 'Equity', format(COALESCE(Equity_9, 0),0), format(COALESCE(Equity_9, 0),0),format(((Equity_9-EquityPrevious_9)/EquityPrevious_9)*100,2)),
                   (28, 'Total Equity and Liabilities', format(COALESCE(EquityuLiabi_9, 0),0),  format(COALESCE(EquityuLiabiPrevious_9, 0),0),format(((EquityuLiabi_9-EquityuLiabiPrevious_9)/EquityuLiabiPrevious_9)*100,2)),
				   (29, '', '', "", ""),
                   (30, 'Cash Flow Statement', varCalendarYear, varCalendarYear - 1, "In USD"),
                   (31, 'Revenue', format(Revenue_9,0), format(RevenuePrevious_9,0), format(((Revenue_9-RevenuePrevious_9)/RevenuePrevious_9)*100,2)),
				   (32, 'Cost of sales', format(COGS_9 	,0),format(COGSPrevious_9,0), format(((COGS_9-COGSPrevious_9)/COGSPrevious_9)*100,2)),
                   (33, 'Administrative Expenses',format(COALESCE(AdminExp_9,0),0), format(COALESCE(AdminExpPrevious_9,0),0), " "),
                   (34, 'Marketing and Selling Expenses',format(COALESCE(SellingExp_9,0),0), format(COALESCE(SellingExpPrevious_9,0),0), format(((SellingExp_9-SellingExpPrevious_9)/SellingExpPrevious_9)*100,2)),
                   (35, 'Other Expenses', format(COALESCE(OtherExp_9,0),0), format(COALESCE(OtherExpPrevious_9,0),0), format(((OtherExp_9-OtherExpPrevious_9)/OtherExpPrevious_9)*100,2)),
                   (36, 'Other Income' , format(COALESCE(OtherIncome_9,0),0), format(COALESCE(OtherIncomePrevious_9,0),0), format(((OtherIncome_9-OtherIncomePrevious_9)/OtherIncomePrevious_9)*100,2))
                   
                   
;

END $$

DELIMITER ;
CALL `H_Accounting.sp_stirpude`(2018); -- getting error on H_Server but if you run this on local it will run. Error i am getting is "Error code:1365 Division by 0" which makes gives me no idea what to fix.
	
SELECT * FROM stirpude_tmp;

select * from statement_section;
