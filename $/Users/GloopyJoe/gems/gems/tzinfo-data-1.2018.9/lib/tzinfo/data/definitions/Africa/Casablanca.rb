# encoding: UTF-8

# This file contains data derived from the IANA Time Zone Database
# (http://www.iana.org/time-zones).

module TZInfo
  module Data
    module Definitions
      module Africa
        module Casablanca
          include TimezoneDefinition
          
          timezone 'Africa/Casablanca' do |tz|
            tz.offset :o0, -1820, 0, :LMT
            tz.offset :o1, 0, 0, :'+00'
            tz.offset :o2, 0, 3600, :'+01'
            tz.offset :o3, 3600, 0, :'+01'
            tz.offset :o4, 3600, -3600, :'+00'
            
            tz.transition 1913, 10, :o1, -1773012580, 10454687371, 4320
            tz.transition 1939, 9, :o2, -956361600, 4859037, 2
            tz.transition 1939, 11, :o1, -950490000, 58310075, 24
            tz.transition 1940, 2, :o2, -942019200, 4859369, 2
            tz.transition 1945, 11, :o1, -761187600, 58362659, 24
            tz.transition 1950, 6, :o2, -617241600, 4866887, 2
            tz.transition 1950, 10, :o1, -605149200, 58406003, 24
            tz.transition 1967, 6, :o2, -81432000, 2439645, 1
            tz.transition 1967, 9, :o1, -71110800, 58554347, 24
            tz.transition 1974, 6, :o2, 141264000
            tz.transition 1974, 8, :o1, 147222000
            tz.transition 1976, 5, :o2, 199756800
            tz.transition 1976, 7, :o1, 207702000
            tz.transition 1977, 5, :o2, 231292800
            tz.transition 1977, 9, :o1, 244249200
            tz.transition 1978, 6, :o2, 265507200
            tz.transition 1978, 8, :o1, 271033200
            tz.transition 1984, 3, :o3, 448243200
            tz.transition 1985, 12, :o1, 504918000
            tz.transition 2008, 6, :o2, 1212278400
            tz.transition 2008, 8, :o1, 1220223600
            tz.transition 2009, 6, :o2, 1243814400
            tz.transition 2009, 8, :o1, 1250809200
            tz.transition 2010, 5, :o2, 1272758400
            tz.transition 2010, 8, :o1, 1281222000
            tz.transition 2011, 4, :o2, 1301788800
            tz.transition 2011, 7, :o1, 1312066800
            tz.transition 2012, 4, :o2, 1335664800
            tz.transition 2012, 7, :o1, 1342749600
            tz.transition 2012, 8, :o2, 1345428000
            tz.transition 2012, 9, :o1, 1348970400
            tz.transition 2013, 4, :o2, 1367114400
            tz.transition 2013, 7, :o1, 1373162400
            tz.transition 2013, 8, :o2, 1376100000
            tz.transition 2013, 10, :o1, 1382839200
            tz.transition 2014, 3, :o2, 1396144800
            tz.transition 2014, 6, :o1, 1403920800
            tz.transition 2014, 8, :o2, 1406944800
            tz.transition 2014, 10, :o1, 1414288800
            tz.transition 2015, 3, :o2, 1427594400
            tz.transition 2015, 6, :o1, 1434247200
            tz.transition 2015, 7, :o2, 1437271200
            tz.transition 2015, 10, :o1, 1445738400
            tz.transition 2016, 3, :o2, 1459044000
            tz.transition 2016, 6, :o1, 1465092000
            tz.transition 2016, 7, :o2, 1468116000
            tz.transition 2016, 10, :o1, 1477792800
            tz.transition 2017, 3, :o2, 1490493600
            tz.transition 2017, 5, :o1, 1495332000
            tz.transition 2017, 7, :o2, 1498960800
            tz.transition 2017, 10, :o1, 1509242400
            tz.transition 2018, 3, :o2, 1521943200
            tz.transition 2018, 5, :o1, 1526176800
            tz.transition 2018, 6, :o2, 1529200800
            tz.transition 2018, 10, :o3, 1540692000
            tz.transition 2019, 5, :o4, 1557021600
            tz.transition 2019, 6, :o3, 1560045600
            tz.transition 2020, 4, :o4, 1587261600
            tz.transition 2020, 5, :o3, 1590285600
            tz.transition 2021, 4, :o4, 1618106400
            tz.transition 2021, 5, :o3, 1621130400
            tz.transition 2022, 3, :o4, 1648346400
            tz.transition 2022, 5, :o3, 1651975200
            tz.transition 2023, 3, :o4, 1679191200
            tz.transition 2023, 4, :o3, 1682215200
            tz.transition 2024, 3, :o4, 1710036000
            tz.transition 2024, 4, :o3, 1713060000
            tz.transition 2025, 2, :o4, 1740276000
            tz.transition 2025, 4, :o3, 1743904800
            tz.transition 2026, 2, :o4, 1771120800
            tz.transition 2026, 3, :o3, 1774144800
            tz.transition 2027, 2, :o4, 1801965600
            tz.transition 2027, 3, :o3, 1804989600
            tz.transition 2028, 1, :o4, 1832205600
            tz.transition 2028, 2, :o3, 1835229600
            tz.transition 2029, 1, :o4, 1863050400
            tz.transition 2029, 2, :o3, 1866074400
            tz.transition 2029, 12, :o4, 1893290400
            tz.transition 2030, 2, :o3, 1896919200
            tz.transition 2030, 12, :o4, 1924135200
            tz.transition 2031, 1, :o3, 1927159200
            tz.transition 2031, 12, :o4, 1954980000
            tz.transition 2032, 1, :o3, 1958004000
            tz.transition 2032, 11, :o4, 1985220000
            tz.transition 2033, 1, :o3, 1988848800
            tz.transition 2033, 11, :o4, 2016064800
            tz.transition 2033, 12, :o3, 2019088800
            tz.transition 2034, 11, :o4, 2046304800
            tz.transition 2034, 12, :o3, 2049933600
            tz.transition 2035, 10, :o4, 2077149600
            tz.transition 2035, 12, :o3, 2080173600
            tz.transition 2036, 10, :o4, 2107994400
            tz.transition 2036, 11, :o3, 2111018400
            tz.transition 2037, 10, :o4, 2138234400
            tz.transition 2037, 11, :o3, 2141863200
          end
        end
      end
    end
  end
end
