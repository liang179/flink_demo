create database mytest;

use mytest;

CREATE TABLE source(
    id INT,
    ts BIGINT,
    vc INT
) WITH (
    'connector'='datagen',
    'rows-per-second'='1',
    'fields.id.kind'='sequence',
    'fields.id.start'='1',
    'fields.id.end'='100',
    'fields.ts.kind'='sequence',
    'fields.ts.start'='1',
    'fields.ts.end'='100',
    'fields.vc.kind'='random',
    'fields.vc.min'='1',
    'fields.vc.max'='100'
);

desc source;

-- SET execution.runtime-mode=streaming;
select * from source;

CREATE TABLE sink(
    id INT,
    ts BIGINT,
    vc INT
) WITH (
    'connector'='print'
);

insert into sink select * from source;

CREATE TABLE t1(
    `event_time` TIMESTAMP(3) METADATA FROM 'timestamp',
    `partition` BIGINT METADATA VIRTUAL,
    `offset` BIGINT METADATA VIRTUAL,
    id int,
    ts bigint,
    vc int
)WITH(
'connector'='kafka',
'properties.bootstrap.servers'='kafka:9092',
'properties.group.id'='flink',
'scan.startup.mode'='earliest-offset', --earliest-offset,'atest-offset,group-offsets,timestamp,specific-offsets
'sink.partitioner'='fixed',
'topic'='flink',
'format'='json'
);

insert into t1(id,ts,vc) select id,ts,vc from source;

select * from t1;