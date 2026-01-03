CREATE OR REPLACE VIEW vw_avg_ltv AS 
select round(avg(vw_ltv_per_customer.ltv),2) AS avg_ltv from vw_ltv_per_customer;

CREATE OR REPLACE VIEW vw_cac_by_channel AS 
select m.channel AS channel,m.total_spend AS total_spend,c.total_customers AS total_customers,round((m.total_spend / c.total_customers),2) AS cac from 
(vw_marketing_by_channel m join vw_customers_by_channel c on((m.channel = c.channel)));

CREATE OR REPLACE VIEW vw_customers_by_channel AS 
select customers.channel AS channel,count(distinct customers.customer_id) AS 
total_customers from customers group by customers.channel;

CREATE OR REPLACE VIEW vw_expenses_clean AS 
select expenses.expense_id AS expense_id,expenses.date AS date,expenses.category AS category,expenses.amount AS amount from expenses where (expenses.amount > 0);

CREATE VIEW vw_ltv_per_customer AS 
select vw_revenue_clean.customer_id AS customer_id,sum(vw_revenue_clean.amount) AS ltv from vw_revenue_clean group by vw_revenue_clean.customer_id;

CREATE VIEW vw_marketing_by_channel AS 
select vw_marketing_clean.channel AS channel,sum(vw_marketing_clean.spend) AS total_spend from vw_marketing_clean group by vw_marketing_clean.channel;

CREATE VIEW vw_marketing_clean AS 
select marketing_spend.marketing_id AS marketing_id,marketing_spend.date AS date,marketing_spend.channel AS channel,marketing_spend.spend AS spend 
from marketing_spend where (marketing_spend.spend > 0);

CREATE VIEW vw_monthly_burn AS 
select date_format(vw_expenses_clean.date,%Y-%m) AS month,sum(vw_expenses_clean.amount) AS burn_rate from vw_expenses_clean group by month;

CREATE VIEW vw_pnl_summary AS
SELECT
    r.total_revenue AS total_revenue,
    e.total_expenses AS total_expenses,
    (r.total_revenue - e.total_expenses) AS net_profit
FROM (SELECT SUM(vw_revenue_clean.amount) AS total_revenue FROM vw_revenue_clean) r
JOIN (SELECT SUM(vw_expenses_clean.amount) AS total_expenses FROM vw_expenses_clean) e;

CREATE VIEW vw_revenue_clean AS
SELECT
    revenue.revenue_id AS revenue_id,
    revenue.date AS date,
    revenue.customer_id AS customer_id,
    revenue.amount AS amount
FROM revenue WHERE revenue.amount > 0;

CREATE VIEW vw_runway AS
SELECT
    c.cash_balance AS cash_balance,
    b.avg_monthly_burn AS avg_monthly_burn,
    ROUND((c.cash_balance / b.avg_monthly_burn), 2) AS runway_months
FROM (SELECT AVG(vw_monthly_burn.burn_rate) AS avg_monthly_burn FROM vw_monthly_burn) b JOIN cash_balance c;

CREATE VIEW vw_unit_economics AS
SELECT
    c.channel AS channel,
    c.cac AS cac,
    l.avg_ltv AS avg_ltv,
    ROUND((l.avg_ltv / c.cac), 2) AS ltv_cac_ratio
FROM vw_cac_by_channel c JOIN vw_avg_ltv l;
