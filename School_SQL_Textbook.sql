DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Book;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Imported_Book;

CREATE TABLE Book (
  bookid INTEGER PRIMARY KEY,
  bookname VARCHAR(40),
  publisher VARCHAR(40),
  price INTEGER
);

CREATE TABLE Customer (
  custid INTEGER PRIMARY KEY,
  name VARCHAR(40),
  address VARCHAR(50),
  phone VARCHAR(20)
);

CREATE TABLE Orders (
  orderid INTEGER PRIMARY KEY,
  custid INTEGER,
  bookid INTEGER,
  saleprice INTEGER,
  orderdate DATE,
  FOREIGN KEY (custid) REFERENCES Customer(custid),
  FOREIGN KEY (bookid) REFERENCES Book(bookid)
);

CREATE TABLE Imported_Book (
  bookid INTEGER,
  bookname VARCHAR(40),
  publisher VARCHAR(40),
  price INTEGER
);

INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구 아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '배구 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');
INSERT INTO Customer VALUES (3, '김연경', '대한민국 경기도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전', NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2024-07-01','%Y-%m-%d'));
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2024-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2024-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2024-07-04','%Y-%m-%d'));
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2024-07-05','%Y-%m-%d'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2024-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE('2024-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2024-07-08','%Y-%m-%d'));
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2024-07-09','%Y-%m-%d'));
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2024-07-10','%Y-%m-%d'));

INSERT INTO Imported_Book VALUES(21, 'Zen Golf', 'Pearson', 12000);
INSERT INTO Imported_Book VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);

COMMIT;

SELECT * FROM Book;
SELECT * FROM Customer;
SELECT * FROM Orders;

SELECT *
FROM    Customer c1
WHERE   EXISTS (SELECT *
                        FROM   Orders c2
                        WHERE  c1.custid = c2.custid);
                        
CREATE TABLE R (
    col1 VARCHAR(20),
    col2 INT
);

INSERT INTO R(col1, col2) VALUES('ABCD', NULL);

INSERT INTO R(col1, col2) VALUES('BC', NULL);

ALTER TABLE R MODIFY col2 INT DEFAULT 10;

INSERT INTO R(col1, col2) VALUES('XY', NULL);

INSERT INTO R(col1) VALUES('EFG');

SELECT SUM(col2) FROM R;

CREATE TABLE R1(
         a INTEGER PRIMARY KEY,
	 b INTEGER
);
CREATE TABLE R2(
	a INTEGER,
	b INTEGER,
	FOREIGN KEY (b) REFERENCES R1 (a) ON DELETE CASCADE);
INSERT INTO R1 VALUES(1, 1);
INSERT INTO R1 VALUES(2, 2);
INSERT INTO R2 VALUES(1, 1);
INSERT INTO R2 VALUES(2, 2);
DELETE FROM R1 WHERE a=1;
SELECT * FROM R2;



CREATE DATABASE exam;

USE exam;

CREATE TABLE DEPT (
    DEPTNO INTEGER NOT NULL,
    DNAME VARCHAR(14),
    LOC VARCHAR(13),
    PRIMARY KEY (DEPTNO)
);
DESC DEPT;

CREATE TABLE EMP (
    EMPNO INTEGER NOT NULL,
    ENAME VARCHAR(10),
    JOB VARCHAR(9),
    MGR INTEGER,
    HIREDATE DATE,
    SAL INTEGER,
    COMM INTEGER,
    DEPTNO INTEGER,
    PRIMARY KEY (EMPNO),
    FOREIGN KEY (DEPTNO) REFERENCES DEPT(DEPTNO)
);


-- 질의 4-1
-- -78과 +78의 절댓값을 구하시오.
SELECT ABS(-78), ABS(+78);

-- 질의 4-2--
-- 4.875를 소수 첫째 자리까지 반올림한 값을 구하시오. 
SELECT ROUND(4.875, 1);

-- 질의 4-3 --
-- 고객별 평균 주문 금액을 100원 단위로 반올림한 값을 구하시오.
SELECT custid '고객번호', ROUND(SUM(saleprice)/COUNT(*), -2) '평균금액'
FROM   Orders
GROUP BY custid;

-- 질의 4-4
-- 도서 제목에 야구가 포함된 도서를 농구로 변경한 후 도서 목록을 나타내시오.
SELECT bookid, REPLACE(bookname, '야구', '농구') bookname, publisher, price 
FROM   Book;

-- 질의 4-5
-- 굿스포츠에서 출판한 도서이ㅡ 제목과 제목의 문자 수, 바이트 수를 나타내시오.
SELECT bookname '제목', CHAR_LENGTH(bookname) '문자수',
	   LENGTH(bookname) '바이트수'
FROM   Book
WHERE  publisher = '굿스포츠';

-- 질의 4-6
-- 마당서점의 고객 중에서 성(姓)이 같은 사람이 몇 명이나 되는지 알고 싶다. 성별 인원수를 구하시오.
SELECT  SUBSTR(name, 1, 1) '성', COUNT(*) '인원'
FROM    Customer
GROUP BY SUBSTR(name, 1, 1);

-- 질의 4-7
-- 마당서점은 주문일로부터 10일 후에 매출을 확정한다. 각 주무닁 확정일자를 구하시오.
SELECT orderid '주문번호', orderdate '주문일',
       ADDDATE(orderdate, INTERVAL 10 DAY) '확정'
FROM   Orders;

-- 질의 4-8
-- 마당서점의 2024년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 나타내시오.
-- 단, 주문일은 '%Y-%m-%d' 형태로 표시한다.
SELECT orderid '주문번호', DATE_FORMAT(orderdate, '%Y-%m-%d') '주문일',
       custid '고객번호', bookid '도서번호'
FROM   Orders
WHERE  orderdate = STR_TO_DATE('20240707', '%Y%m%d');

-- 질의 4-9
-- DBMS 서버에 설정된 현재 날짜와 시간, 요일을 확인하시오.
SELECT SYSDATE(),
       DATE_FORMAT(SYSDATE(), '%Y/%m/%d %a %h:%i') AS 'SYSDATE_1';
       
-- 질의 4-10
-- 이름, 전화번호가 포함된 고객 목록을 나타내시오. 단, 전화번호가 없는 고객은 '연락처없음'으로 표시하시오.
SELECT name '이름', IFNULL(phone, '연락처없음') '전화번호'
FROM Customer;

-- 질의 4-11
-- 고객 목록에서 고객번호, 이름, 전화번호를 앞의 2명만 나타내시오.
SET   @seq:=0;

SELECT (@seq:=@seq+1) '순번', custid, name, phone
FROM   Customer
WHERE  @seq < 2;  

-- 질의 4-12
-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 나타내시오.
SELECT orderid, saleprice
FROM Orders
WHERE saleprice <= (SELECT AVG(saleprice)
				    FROM Orders);

-- 질의 4-13
-- 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호, 금액을 나타내시오.
SELECT orderid, custid, saleprice
FROM Orders od1
WHERE saleprice > (SELECT AVG(saleprice)
                   FROM Orders od2
                   WHERE od1.custid = od2.custid);
                   
-- 질의 4-14
-- 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
   SELECT SUM(saleprice) 'total'   
   FROM Orders
   WHERE custid IN (SELECT custid
                    FROM Customer
					WHERE address LIKE '%대한민국%');
                    
-- 질의 4-15
-- 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 판매금액을 보이시오.
SELECT orderid, saleprice
FROM Orders
WHERE saleprice > ALL(SELECT saleprice 
                      FROM Orders
					  WHERE custid = '3');
                      
-- 질의 4-16
-- EXISTS 연산자를 사용하여 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
SELECT SUM(saleprice) 'total'
FROM Orders od
WHERE EXISTS (SELECT *
			  FROM Customer cs
			  WHERE address LIKE '%대한민국%' AND cs.custid=od.custid);
              
-- 질의 4-17
-- 마당서멎의 고객별 판매액을 나타내시오(고객이름과 고개별 판매액 출력).
SELECT (SELECT      name
        FROM        Customer cs
        WHERE       cs.custid = od.custid) 'name' , SUM(saleprice) 'total'
FROM    Orders od
GROUP BY od.custid;

-- 질의 4-18
-- Orders 테이블에 각 주문에 맞는 도서이름을 입력하시오.
ALTER TABLE Orders ADD bname VARCHAR(40);
UPDATE Orders
SET    bname = (SELECT bookname
				FROM Book
                WHERE Book.bookid = Orders.bookid);

-- 질의 4-19
-- 고객번호가 2이하인 고객의 판매액을 나타내시오(고객이름과 고개별 판매액 출력)
SELECT cs.name, SUM(od.saleprice) 'total'
FROM   (SELECT custid, name
		FROM   Customer
        WHERE  custid <= 2) cs,
        Orders od
WHERE   cs.custid = od.custid
GROUP BY cs.name;

-- 질의 4-20
-- 주소에 '대한민국'을 포함하는 고객들로 구성된 뷰를 만들고 조회하시오. 뷰의 이름은 vw_Customer로 설정하시오.
CREATE VIEW vw_Customer
AS SELECT *
   FROM Customer
   WHERE address LIKE '%대한민국%';

-- 확인해보면
SELECT * FROM vw_Customer;

-- 질의 4-21
-- Orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성한 후,
-- '김연아' 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 나타내시오.

CREATE VIEW vw_Orders (orderid, custid, name, bookid, bookname, 
                       saleprice, orderdate)
AS SELECT od.orderid, od.custid, cs.name,
          od.bookid, bk.bookname, od.saleprice, od.orderdate
   FROM Orders od, Customer cs, Book bk
   WHERE od.custid = cs.custid AND od.bookid = bk.bookid;

SELECT orderid, bookname, saleprice
FROM vw_Orders
WHERE name = '김연아';

-- 질의 4-22
-- [질의 4-20]에서 생성한 뷰 vw_Customer는 주소가 대한민국인 고객을 보여준다. 이 뷰를 
-- 영국을 주소로 가진 고객으로 변경하시오. phone 속성은 필요 없으므로 포함하지 마시오.

CREATE OR REPLACE VIEW vw_Customer (custid, name, address)
AS SELECT custid, name, address
   FROM Customer
   WHERE address LIKE '%영국%';

SELECT * FROM vw_Customer;

-- 질의 4-23
-- 앞서 생성한 뷰 vw_Customer를 삭제하시오.
DROP VIEW vw_Customer;

-- 질의 4-24
-- Book 테이블의 bookname 열을 대상으로 인덱스 ix_Book을 생성하시오.
CREATE INDEX ix_Book ON Book(bookname);

-- 질의 4-25
-- Book 테이블이 publisher, price 열을 대상으로 인덱스 ix_Book2를 생성하시오.
CREATE INDEX ix_Book2 ON Book(publisher, price);

-- 생성된 인덱스는 SHOW INDEX 명령어로 확인할 수 있다.
SHOW INDEX FROM BOOK;

SELECT * 
FROM   Book
WHERE publisher = '대한미디어' AND price >= 30000;

-- 질의 4-26
-- Book 테이블의 인덱스를 최적화하시오.
ANALYZE TABLE Book;

-- 질의 4-27
-- 인덱스 ix_Book을 삭제하시오.
DROP INDEX ix_Book ON Book; 

-- CEHCK OUT 
SELECT ABS(-78), ABS(+78);



   