hive-testbench
==============

A testbench for experimenting with Apache Hive at Arenadata Hadoop 2.1.

Overview
========

The hive-testbench is a data generator and set of queries that lets you experiment with Apache Hive at scale. The testbench allows you to experience base Hive performance on large datasets, and gives an easy way to see the impact of Hive tuning parameters and advanced settings.

Prerequisites
=============

You will need:
* ADH 2.1 cluster on RH 7/Centos 7.
* Apache Hive.
* Between 15 minutes and 2 days to generate data (depending on the Scale Factor you choose and available hardware).

Install and Setup
=================

All of these steps should be carried out on your ADH 2.1 cluster.

- Step 1: Prepare your environment.
-- Load and unzip repo
```
cd /opt
wget https://github.com/stanislav-gabdulgaziev/hive-testbench/archive/refs/heads/adh21.zip
unzip adh21.zip
cd adh21/
```

--install maven and devtools for compile
```
yum install maven
yum install java-devel
```
-- compile all for tpc-ds test
```
cd /root/hive-testbench-adh21/tpcds-gen
make
```

- Step 4: Decide how much data you want to generate.

  You need to decide on a "Scale Factor" which represents how much data you will generate. Scale Factor roughly translates to gigabytes, so a Scale Factor of 100 is about 100 gigabytes and one terabyte is Scale Factor 1000. Decide how much data you want and keep it in mind for the next step. If you have a cluster of 4-10 nodes or just want to experiment at a smaller scale, scale 1000 (1 TB) of data is a good starting point. If you have a large cluster, you may want to choose Scale 10000 (10 TB) or more. The notion of scale factor is similar between TPC-DS and TPC-H.

  If you want to generate a large amount of data, you should use Hive 13 or later. Hive 13 introduced an optimization that allows far more scalable data partitioning. Hive 12 and lower will likely crash if you generate more than a few hundred GB of data and tuning around the problem is difficult. You can generate text or RCFile data in Hive 13 and use it in multiple versions of Hive.

- Step 5: Generate and load the data.

  The scripts ```tpcds-setup.sh``` and ```tpch-setup.sh``` generate and load data for TPC-DS and TPC-H, respectively. General usage is ```tpcds-setup.sh scale_factor [directory]``` or ```tpch-setup.sh scale_factor [directory]```

  Some examples:

  Build 1 TB of TPC-DS data in ORC format with logs ```nohup ./tpcds-setup.sh 1000 >>/tmp/tptcd-setup_1000.log 2>&1 &```
  
  Build 1 TB of TPC-DS data: ```./tpcds-setup.sh 1000```

  Build 1 TB of TPC-H data: ```./tpch-setup.sh 1000```

  Build 100 TB of TPC-DS data: ```./tpcds-setup.sh 100000```

  Build 30 TB of text formatted TPC-DS data: ```FORMAT=textfile ./tpcds-setup 30000```

  Build 30 TB of RCFile formatted TPC-DS data: ```FORMAT=rcfile ./tpcds-setup 30000```
  
  Also check other parameters in setup scripts important one is BUCKET_DATA.

  

- Step 6: Run queries.
  You can use manual startup in beeline or hive or using a script runSuit.py for automation. 
- Before edit the section "Tuning" in the sample-queries-tpcds/testbench.settings file

  More than 50 sample TPC-DS queries and all TPC-H queries are included for you to try. You can use ```hive```, ```beeline``` or the SQL tool of your choice. The testbench also includes a set of suggested settings.

  This example assumes you have generated 1 TB of TPC-DS data during Step 5:

      ```
      cd sample-queries-tpcds
      hive -i testbench.settings
      hive> use tpcds_bin_partitioned_orc_1000;
      hive> source query55.sql;
      ```

  Note that the database is named based on the Data Scale chosen in step 3. At Data Scale 10000, your database will be named tpcds_bin_partitioned_orc_10000. At Data Scale 1000 it would be named tpch_flat_orc_1000. You can always ```show databases``` to get a list of available databases.

  Similarly, if you generated 1 TB of TPC-H data during Step 5:

      ```
      cd sample-queries-tpch
      hive -i testbench.settings
      hive> use tpch_flat_orc_1000;
      hive> source tpch_query1.sql;
      ```
