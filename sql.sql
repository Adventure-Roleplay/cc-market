CREATE TABLE `market_prices` (
  `item_name` varchar(100) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `price_change` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;