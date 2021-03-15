--기존 계정 삭제 및 새로운 계정 생성--
DROP USER housemate CASCADE;

CREATE USER housemate IDENTIFIED BY housemate DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;

GRANT CONNECT, RESOURCE TO housemate;
GRANT CREATE VIEW, CREATE SYNONYM TO housemate;

ALTER USER housemate ACCOUNT UNLOCK;

conn housemate/housemate;


--기존 테이블 삭제--
DROP TABLE rsv;
DROP TABLE bld;
DROP TABLE cst;
DROP TABLE realtor;


--테이블 생성--
ALTER SESSION SET nls_date_format='YYYY-MM-DD';
--<realtor>
--중개사자격증번호(PK), 중개인회원ID, 비밀번호, 중개업체명, 사업자번호, 대표자명, 연락처, 메일, 주소
--Rcode, Rid, Rpw, officename, buinessno, Rname, Rphone, Remail, Raddress
CREATE TABLE REALTOR (
  Rcode varchar2(20),
  Rid varchar2(20),
  Rpw varchar2(20),
  officename varchar2(40),
  businessno number,
  Rname varchar2(20),
  Rphone varchar2(20),
  Remail varchar2(30),
  Raddress varchar2(70)
);

--<bld>
--매물코드(PK), 지역, 주소, 주거형태, 계약형태, 매물보증금(천만원 단위), 매물월세(전세/매매일 경우 0으로 표기, 만원 단위), 면적, 중개사자격증번호(FK)
--Bcode, Blocation, Baddress, house, contract, price, monthly, area, Rcode
CREATE TABLE BLD (
  Bcode number,
  Blocation varchar2(25),
  Baddress varchar2(70),
  house varchar2(20),
  contract varchar2(20),
  price number,
  monthly number,
  area varchar2(20),
  Rcode varchar2(20)
);


--<RSV>
--예약번호(PK), 예약날짜, 매물번호(FK), 회원번호(FK), 중개사자격증번호(FK)
--Rsequence, Rdate, Bcode, Ccode, Rcode
CREATE TABLE RSV (
 Rsequence number,
 Rdate varchar2(20),
 Bcode number,
 Ccode number,
 Rcode varchar2(20)
);

--<CST> 
--회원번호(PK), 회원id, 비밀번호, 회원이름, 주민등록번호, 회원전화번호, 회원이메일, 회원주소, 가입일자
--Ccode, Cid, Cpw, Cname, gcode, Cphone, Cemail, Caddress, joindate
CREATE TABLE CST (
 Ccode number,
 Cid varchar2(30),
 Cpw varchar2(20),
 Cname varchar2(30),
 gcode varchar2(14),
 Cphone varchar2(20),
 Cemail varchar2(70),
 Caddress varchar2(70),
 joindate date
);

DROP SEQUENCE bcode_seq;
DROP SEQUENCE ccode_seq;
DROP SEQUENCE rsequence_seq;

CREATE SEQUENCE bcode_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE ccode_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;

CREATE SEQUENCE rsequence_seq
START WITH 1
INCREMENT BY 1
NOMAXVALUE
NOMINVALUE
NOCYCLE
NOCACHE;


--매물 데이터 삽입--
--<BLD>
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '방배 현대 1차 103동', '아파트', '매매', 136000, 0, '82㎡', '02-2019-44989');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '3001-2번지 방배디오슈페리움 1차 A동', '아파트', '매매', 175000, 0, '231㎡', '10-2020-04817');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '방배천로 방배노블레스룸 101동', '투룸', '월세', 5000, 150, '42㎡', '07-1995-50209');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '902-12 워터빌', '원룸', '전세', 43000, 0, '12㎡', '12-2015-60227');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '방배천로 22길 럭셔리풀', '오피스텔', '매매', 125000, 0, '22㎡','02-2019-44989');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '98-123 2층', '상가', '월세', 8000, 150, '220㎡', '10-2020-04817');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '서초대로 29', '상가', '매매', 235000, 0, '197㎡', '07-1995-50209');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '방배로 203길 10', '투룸', '월세', 9500, 180, '79㎡', '12-2015-60227');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '방배천로 76', '원룸', '월세', 8000, 150, '42㎡','02-2019-44989');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '방배로 219-3', '상가', '매매', 235000, 0, '197㎡', '10-2020-04817');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '방배로 73 미동 라', '투룸', '월세', 8000, 180, '79㎡', '07-1995-50209');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '서초구 방배동', '방배로 200', '원룸', '월세', 5000, 150, '42㎡', '12-2015-60227');
commit;

INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '북천로 116', '상가', '월세', 9000, 120, '64㎡', '11-2001-98032');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '율곡로 20', '아파트', '매매', 22000, 0, '85㎡', '11-2001-98032');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '계동길 87-20', '아파트', '전세', 43000, 0, '83㎡', '11-2001-98032');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '북천로 4길 8', '투룸', '월세', 6000, 90, '47㎡', '11-2001-98032');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '삼청로 102-6', '원룸', '월세', 3000, 80, '31㎡', '10-2014-19375');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '삼청로 123-12', '아파트', '월세', 9000, 95, '89㎡', '10-2014-19375');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '삼청동 201', '아파트', '매매', 343000, 0, '243㎡', '10-2014-19375');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '율곡로 3길 126', '투룸', '월세', 3000, 78, '131㎡', '10-2014-19375');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '북천로 102-2', '오피스텔', '월세', 6000, 80, '67㎡', '06-1991-60720');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '삼청로 111', '상가', '월세', 9000, 2000, '101㎡', '06-1991-60720');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '북천로 112-16', '원룸', '전세', 49000, 0, '30㎡', '06-1991-60720');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '율곡대로 29길', '아파트', '전세', 30000, 0, '25㎡', '11-2008-15438');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '계동길 11', '아파트', '전세', 72000, 0, '78㎡', '11-2008-15438');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '북천로 143-3', '투룸', '월세', 7000, 90, '24㎡', '11-2008-15438');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '삼청로 198', '원룸', '월세', 1000, 120, '21㎡', '11-2008-15438');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '삼청로 101-1', '아파트', '월세', 8500, 55, '76㎡', '16-2016-34298');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '삼청동 123', '원룸', '월세', 9500, 35, '23㎡', '16-2016-34298');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '율곡로 2길 126', '투룸', '월세', 3000, 78, '131㎡', '16-2016-34298');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '북천로 89', '오피스텔', '월세', 7000, 50, '57㎡', '16-2016-34298');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '종로구 삼청동', '삼청로 4','상가', '월세', 7500, 1000, '91㎡', '16-2016-34298');
commit;

INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '이태원로 294', '아파트', '매매', 137000, 0, '57㎡', '12-2007-10221');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '남산공원길 105', '아파트', '전세', 49000, 0, '106㎡', '08-2008-80808');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '소월로 322', '아파트','월세', 9900, 100, '76㎡', '09-2015-12342');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '독서당로29길 5-6 Replace한남', '원룸', '매매', 52000, 0, '89㎡', '01-1998-36014');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '회나무로 54', '원룸', '전세', 17000, 0, '43㎡', '10-2011-30470');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '소월로44길 2-12', '원룸', '월세', 5000, 50, '46㎡', '10-2011-09271');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '녹사평대로46길 64', '투룸', '매매', 8700, 0, '69㎡', '12-2007-10221');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '녹사평대로40가길 2-3', '아파트', '전세', 45000, 0, '159㎡', '08-2008-80808'); 
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '신흥로 14 상가 3동', '투룸', '월세', 9500, 75, '79㎡', '09-2015-12342');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '두텁바위로 65', '아파트', '매매', 175000, 0, '69㎡', '01-1998-36014');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '후암로28바길 25', '오피스텔', '전세', 20000, 0, '185㎡', '10-2011-30470');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '한강대로102가길 18', '오피스텔', '월세', 7500, 35, '43㎡', '10-2011-09271');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '회나무로13가길 57', '상가', '매매', 95000, 0, '397㎡', '12-2007-10221');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '이태원로26길 18', '상가', '월세', 9000, 80, '248㎡', '08-2008-80808');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '보광로 116', '상가', '월세', 9900, 100, '331㎡', '09-2015-12342');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '녹사평대로26나길 2', '원룸', '월세', 4000, 45, '185㎡', '01-1998-36014');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '보광로50길 24-9', '투룸', '전세', 75000, 0, '69㎡', '10-2011-30470');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '우사단로10길 11', '아파트', '전세', 46000, 0, '106㎡', '10-2011-09271');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '장문로 12', '아파트', '전세', 45000, 0, '106㎡', '12-2007-10221');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '보광로 105 2층', '원룸', '전세', 12000, 0, '30㎡', '08-2008-80808');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '이태원로20길 13', '투룸', '월세', 9000, 80, '89㎡', '09-2015-12342');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '녹사평대로40다길 2 그린빌라트', '투룸', '전세', 29000, 0, '79㎡', '01-1998-36014');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '녹사평대로40다길 40', '원룸', '월세', 8000, 90, '185㎡', '10-2011-30470');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '회나무로44길 154', '아파트', '매매', 150000, 0, '89㎡', '10-2011-09271');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, RCODE) VALUES (bcode_seq.NEXTVAL, '용산구 이태원동', '이태원로27길 101', '아파트', '전세', 48500, 0, '112㎡', '12-2007-10221');
commit;

INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '월드컵로25길 125', '아파트', '월세', 9000, 90, '84.4㎡', '18-2009-13207');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '월드컵로25길 125', '아파트', '매매', 137000, 0, '109.3㎡', '18-2009-13207');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '월드컵로25길 122', '아파트', '전세', 49500, 0, '127㎡', '18-2009-13207');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '월드컵로25길 128', '아파트', '매매', 102000, 0, '89.9㎡', '18-2009-13207');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '월드컵로25길 128', '아파트', '전세', 49000, 0, '117.6㎡', '18-2009-13207');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '월드컵로25길 128', '아파트', '월세', 9500, 85, '89.9㎡', '15-2010-64315');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '월드컵로29길 11', '아파트', '전세', 32000, 0, '69.52㎡', '15-2010-64315');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '망원로3길 25 에덴쉐르빌', '오피스텔', '월세', 3000, 30, '43㎡', '15-2010-64315');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '망원로3길 21 중앙하이츠', '투룸', '전세', 33000, 0, '62.3㎡', '15-2010-64315');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '월드컵로29길 116-6 뫼비우스', '오피스텔', '전세', 21000, 0, '47.7㎡', '15-2010-64315');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '망원로 36 한강로얄스위트', '오피스텔', '월세', 4000, 40, '70㎡', '15-2010-64315');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '망원로 36 한강로얄스위트', '오피스텔', '매매', 85000, 0, '70㎡', '02-2018-21933');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '망원로4길 8', '아파트', '전세', 48000, 0, '106.3㎡', '02-2018-21933');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '망원로4길 8', '아파트', '월세', 9000, 70, '80.8㎡', '02-2018-21933');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '망원로1길 27', '아파트', '전세', 49500, 0, '109.6㎡', '02-2018-21933');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '망원로1길 27', '아파트', '매매', 127000, 0, '109.6㎡', '16-2016-01011');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '포은로 129', '원룸', '월세', 1000, 25, '39.3㎡', '16-2016-01011');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '망원로 61 2층', '투룸', '월세', 2500, 25, '42㎡', '16-2016-01011');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '방울내로9길 12', '상가', '월세', 5000, 40, '68㎡', '14-1997-78013');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '희우정로 128 1층', '원룸', '매매', 50000, 0, '24㎡', '14-1997-78013');
INSERT INTO BLD (BCODE, blocation, baddress, house, contract, price, monthly, area, rcode) VALUES (bcode_seq.NEXTVAL, '마포구 망원동', '동교로3길 79', '상가', '매매', 66000, 0, '49.2㎡', '14-1997-78013');
commit;

--회원 데이터 삽입--
--<CST>--
INSERT INTO CST (ccode, cid, cpw, cname, gcode, cphone, cemail, caddress, joindate) VALUES (ccode_seq.NEXTVAL, 'helloworld', '0000', '심재윤', '021115-3031313', '010-2002-1115', 'helloworld@fake.com', '서울시 마포구 망원동 망원로 61 2층', '2020/12/24');
INSERT INTO CST (ccode, cid, cpw, cname, gcode, cphone, cemail, caddress, joindate) VALUES (ccode_seq.NEXTVAL, 'iceskater', '0000', '박성훈', '021208-3031312', '010-2002-1208', 'iceskater@fake.com', '서울시 마포구 망원동 동교로 3길 79', '2020/12/24');
INSERT INTO CST (ccode, cid, cpw, cname, gcode, cphone, cemail, caddress, joindate) VALUES (ccode_seq.NEXTVAL, 'sheepgarden', '0000', '양정원', '040209-3031311', '010-2004-0209', 'sheepgarden@fake.com', '서울시 마포구 망원동 포은로 129', '2020/12/24');


--중개인 데이터 삽입--
--<REALTOR>
INSERT INTO REALTOR VALUES  ('02-2019-44989','ysb4989','0000','행복부동산',543278,'연수빈','010-3246-1215','ysb4989@gmail.com','서울 서초구 토정로 159');
INSERT INTO REALTOR VALUES  ('10-2020-04817','10004better','1111','스테이션부동산',165327,'이제우','010-1234-5678','10004better@gmail.com','서울 서초구 서초로 239');
INSERT INTO REALTOR VALUES  ('07-1995-50209','johnjsuh','2222','네오공인중개사',024135,'서영호','010-1995-0209','johnjsuh@gmail.com','서울 서초구 서초로14길 50-3');
INSERT INTO REALTOR VALUES  ('12-2015-60227','tenlee96','3333','테크부동산',563217,'이영흠','010-1996-0227','tenlee96@gmail.com','서울 서초구 서초로 275 효창파크스위첸상가 103호');
INSERT INTO REALTOR VALUES  ('11-2001-98032','jeongjinsu','4444','문화공인중개사',341502,'정성찬','010-2001-0913','jinsuseongchan@hanmail.net','서울 종로구 통인로1길 10');
INSERT INTO REALTOR VALUES  ('10-2014-19375','limsw91','5555','하우스911부동산',032119,'임상우','010-9876-5432','limsw91@naver.com','서울 종로구 숭문길 216');
INSERT INTO REALTOR VALUES  ('06-1991-60720','wonderboy','6666','국민부동산',170670,'이원덕','010-9797-1313','wonderboy@korea.com','서울 종로구 백범로37길 22');
INSERT INTO REALTOR VALUES  ('11-2008-15438','yohoyj','7777','비트부동산',303541,'장연정','010-0012-3456','bitcamp@bit.com','서울 종로구 백범로 23 구프라자 3층');
INSERT INTO REALTOR VALUES  ('16-2016-34298','triplek','8888','내가찾던바로그부동산',179852,'김가경','010-0098-7865','triplek@gmail.com','서울 종로구 종로26길 15');
INSERT INTO REALTOR VALUES  ('13-2017-05765','doublej','9999','바로여기부동산',224751,'정지희','010-0034-5678','doublej@gmail.com','서울 용산구 해방로36길 49');
INSERT INTO REALTOR VALUES  ('12-2007-10221','kangsky','0221','모드부동산',973654,'강하늘','010-1991-0221','kangsky0221@hanmail.net','서울 용산구 해방촌로 274 크라운뷰');
INSERT INTO REALTOR VALUES  ('08-2008-80808','xiaojun0808','8888','광동복덕방',546982,'소덕준','010-1999-0808','xiaodejun@gmail.com','서울 용산구 이태원로8길 20 자선메르시안아파트');
INSERT INTO REALTOR VALUES  ('09-2015-12342','sheqerke','1010','초록부동산',091242,'석선유','010-2016-0416','sheqerke@lycos.com','서울 용산구 한강로 27 한강푸르지오');
INSERT INTO REALTOR VALUES  ('01-1998-36014','square0718','1212','마름모공인중개사',729321,'노정민','010-2017-5310','square0718@tmmom.net','서울 용산구 용산로19길 21');
INSERT INTO REALTOR VALUES  ('10-2011-30470','dimsumlike','1313','천가네부동산',209385,'천민지','010-7584-2150','dimsummo@gmail.com','서울 용산구 자곡로 204-5');
INSERT INTO REALTOR VALUES  ('10-2011-09271','workinginjpn','1414','조마루부동산',923027,'조하연','010-6438-5555','oenoza@working.co.jp','서울 마포구 홍45길 68-6 서광등촌마을');
INSERT INTO REALTOR VALUES  ('18-2009-13207','wangjjaboo','1515','해피공인중개사',849210,'김채오','010-8416-3535','msjjaboo@naver.com','서울 마포구 월드컵로17길 37 1층');
INSERT INTO REALTOR VALUES  ('15-2010-64315','pingpangpong','1616','럭키부동산',548676,'전유빈','010-1246-6827','pingpangpong@gmail.com','서울 마포구 희우정로23길 177');
INSERT INTO REALTOR VALUES  ('02-2018-21933','musicstar','1717','스타부동산',328516,'주진락','010-2001-0972','musicstarcl@gmail.com','서울 마포구 방울내로45길 10-25 베리타스타운');
INSERT INTO REALTOR VALUES  ('16-2016-01011','magiciankun','1818','돈버는부동산',113458,'전곤','010-1996-0101','xiaodan@gmail.com','서울 마포구 동교로2길 6-1');
INSERT INTO REALTOR VALUES  ('14-1997-78013','dongyoungk','1919','공명공인중개사',960201,'김동영','010-6524-7545','dongyoungk@gmail.com','서울 마포구 연희로 37 102호');
commit;

--예약 데이터 삽입--
--<RSV>--
INSERT INTO RSV (rsequence, rdate, bcode, ccode, rcode) VALUES (rsequence_seq.NEXTVAL, '2020/12/31', 12, 3, '07-1995-50209');
INSERT INTO RSV (rsequence, rdate, bcode, ccode, rcode) VALUES (rsequence_seq.NEXTVAL, '2020/12/31', 15, 4, '12-2015-60227');

--Ccode sequence
INSERT INTO CST(ccode) VALUES(ccode_seq.NEXTVAL);
--Rsequence
INSERT INTO RSV(rsequence) VALUES(rsequence_seq.NEXTVAL);


--제약조건 부분
--REALTOR PK
ALTER TABLE realtor
ADD CONSTRAINT realtor_rcode_pk PRIMARY KEY(rcode);

--BLD PK
ALTER TABLE bld
ADD CONSTRAINT bld_bcode_pk PRIMARY KEY(bcode);
--BLD FK
ALTER TABLE bld
ADD CONSTRAINT bld_rcode_fk FOREIGN KEY (rcode) REFERENCES realtor (rcode);

--CST PK
ALTER TABLE cst
ADD CONSTRAINT cst_ccode_pk PRIMARY KEY (ccode);

--RSV PK
ALTER TABLE rsv
ADD CONSTRAINT rsv_rsequence_pk PRIMARY KEY (rsequence);
--RSV FK
ALTER TABLE rsv
ADD CONSTRAINT rsv_bcode_fk FOREIGN KEY (bcode) REFERENCES bld (bcode);
ALTER TABLE rsv
ADD CONSTRAINT rsv_ccode_fk FOREIGN KEY (ccode) REFERENCES cst (ccode);
ALTER TABLE rsv
ADD CONSTRAINT rsv_rcode_fk FOREIGN KEY (rcode) REFERENCES realtor (rcode);


DROP VIEW rsv_view;

--RSV_VIEW 뷰 생성--
--<RSV_VIEW>--
ALTER SESSION SET nls_date_format='YYYY-MM-DD';
CREATE VIEW rsv_view (회원코드, 회원이름, 예약번호, 예약날짜, 매물번호, 소재지역, 매물주소, 주거형태, 계약형태, 
            "매매가/전세/보증금", 월세, 면적, 중개사사무소, 중개인, 중개인연락처, 회원아이디)
AS SELECT c.ccode, cname, rsequence, rdate, b.bcode, blocation, baddress, house, contract, 
            price, monthly, area, officename, rname, rphone, cid
FROM realtor t, rsv v, bld b, cst c
WHERE t.rcode=v.rcode
AND b.bcode=v.bcode
AND c.ccode=v.ccode;


--DROP 정보 비우기
purge recyclebin;


--테이블 설정 상태
col column_name format a15
col value format a30
col table_name  format a15
col CONSTRAINT_NAME format a20
col R_OWNER format a10
col R_CONSTRAINT_NAME format a20
col OBJECT_NAME format a20
col SEARCH_CONDITION format a20
col file_name format a40
col tablespace_name format a16
col member format a38
col name format a40
col table_name format a20
col segment_name format a20
col owner format a16
col ROW_ID format a19
col profile format a20
col limit format a20
col COMMENTS format a65
col grantor format a10
col grantee format a10
col table_schema format a15
col table_name format a15
col privilege format a31
col gra format a10 
col type format a30
col Null? format a10
col WAIT_CLASS format a16
col parameter1 format a25
col parameter3 format a25
col parameter2 format a25
col event format a30
col PROPERTY_NAME format a30
col PROPERTY_VALUE format a10
col DESCRIPTION format a40 
col username format a10
col PROFILE format a10
col DEFAULT_TABLESPACE format a10
col ACCOUNT_STATUS format a20
col temporary_tablespace format a10



set line 64
set pages 200
alter session set nls_date_format='YYYY/MM/DD';
col rcode format a20
col rid format a20
col cid format a20
col officename format a20
col rname format a20
col rphone format a20
col remail format a30
col raddress format a50
col blocation format a20
col baddress format a50
col house format a20
col conrtract format a20
col area format a20
col cpw format a20
col cname format a20
col gcode format a14
col cphone format a20
col cemail format a20
col caddress format a20
col table_name format a10
col column_name format a14
col data_type format a14
col constraint_name format a28
col name format a10
COL column_expression FORMAT a40
COL INDEX_NAME FORMAT a20
