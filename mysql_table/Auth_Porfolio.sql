CREATE SCHEMA `db_auth`;

CREATE TABLE `db_auth`.`tb_auth_social` (
  `service_id` varchar(255) COMMENT '서비스 ID',
  `provider` varchar(255) COMMENT '제공자 ex)google',
  `social_id` varchar(255) COMMENT '소셜 유니크 ID',
  `account_key` varchar(255) NOT NULL COMMENT 'Account 연동 키',
  `link_key` varchar(255) NOT NULL COMMENT 'Social 연동 키',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 날짜',
  PRIMARY KEY (`service_id`, `provider`, `social_id`)
);

CREATE TABLE `db_auth`.`tb_auth_wallet` (
  `service_id` varchar(255) COMMENT '서비스 ID',
  `network` varchar(255) COMMENT 'Wallet 네트워크',
  `address` varchar(255) COMMENT 'Wallet 주소',
  `account_key` varchar(255) NOT NULL COMMENT 'Account 연동 키',
  `link_key` varchar(255) NOT NULL COMMENT 'Wallet 연동 키',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 날짜',
  PRIMARY KEY (`service_id`, `network`, `address`)
);

CREATE TABLE `db_auth`.`tb_auth_email` (
  `service_id` varchar(255) COMMENT '서비스 ID',
  `email` varchar(255) COMMENT 'Email 주소',
  `password` varchar(255) NOT NULL COMMENT '이메일 비밀번호',
  `verify_yn` tinyint NOT NULL DEFAULT 0 COMMENT '이메일 인증 여부',
  `account_key` varchar(255) NOT NULL COMMENT 'Account 연동 키',
  `link_key` varchar(255) NOT NULL COMMENT 'Email 연동 키',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 날짜',
  PRIMARY KEY (`service_id`, `email`)
);

CREATE TABLE `db_auth`.`tb_auth_passkey` (
  `service_id` varchar(255) COMMENT '서비스 ID',
  `passkey_id` varchar(255) COMMENT 'Passkey ID',
  `public_key` text NOT NULL COMMENT 'Paaskey 인증서 퍼블릭 키',
  `user_handle` varchar(255) NOT NULL,
  `signature_count` int NOT NULL DEFAULT 0,
  `cred_type` varchar(255) NOT NULL,
  `aa_guid` varchar(255) NOT NULL,
  `account_key` varchar(255) NOT NULL COMMENT 'Account 연동 키',
  `link_key` varchar(255) NOT NULL COMMENT 'Passkey 연동 키',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간',
  PRIMARY KEY (`service_id`, `passkey_id`)
);

CREATE TABLE `db_auth`.`tb_auth_guest` (
  `service_id` varchar(255) COMMENT '서비스 ID',
  `device_id` varchar(255) COMMENT '디아비스 ID',
  `account_key` varchar(255) NOT NULL COMMENT 'Account 연동 키',
  `link_key` varchar(255) NOT NULL COMMENT 'Guest 연동 키',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간',
  PRIMARY KEY (`service_id`, `device_id`)
);

CREATE TABLE `db_auth`.`tb_auth_account` (
  `uid` bigint PRIMARY KEY AUTO_INCREMENT COMMENT '유저 ID',
  `account_key` varchar(255) NOT NULL COMMENT 'Account 연동 키',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간'
);

CREATE TABLE `db_auth`.`tb_auth_blacklist` (
  `uid` bigint COMMENT '유저 ID',
  `project_id` varchar(255) COMMENT '프로젝트 ID',
  `status` varchar(255) NOT NULL COMMENT '제재 상태',
  `desciption` varchar(255) NOT NULL COMMENT '제재 사유',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간',
  `expire_date` timestamp NOT NULL COMMENT '만료 시간',
  PRIMARY KEY (`uid`, `project_id`)
);

CREATE TABLE `db_auth`.`tb_auth_email_verify_config` (
  `project_id` varchar(255) PRIMARY KEY COMMENT '프로젝트 ID',
  `signup_verify_yn` tinyint NOT NULL DEFAULT 0 COMMENT '회원가입 시 인증 메일 발송 여부',
  `signin_verify_yn` tinyint NOT NULL DEFAULT 1 COMMENT '인증된 메일만 로그인 가능하도록 할지 여부',
  `subject` varchar(255) NOT NULL COMMENT '인증 메일 제목',
  `body` text NOT NULL COMMENT '인증 메일 내용',
  `sender_email` varchar(255) NOT NULL COMMENT '메일 발송자 주소',
  `api_key` varchar(255) NOT NULL COMMENT 'SendGrid API Key',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간'
);

CREATE TABLE `db_auth`.`tb_auth_oauth_config` (
  `project_id` varchar(255) COMMENT '프로젝트 ID',
  `provider` varchar(255) COMMENT '제공자 ex)google',
  `client_data` json NOT NULL COMMENT 'Oauth 2.0 설정 정보',
  `redirect_uri` varchar(255) NOT NULL COMMENT '인증 후 리다이렉트 시킬 앤드 포인트',
  `scope` varchar(255) NOT NULL COMMENT '인증 권한 범위',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간',
  PRIMARY KEY (`project_id`, `provider`)
);

CREATE TABLE `db_auth`.`tb_auth_wallet_signature_message_config` (
  `project_id` varchar(255) PRIMARY KEY COMMENT '프로젝트 ID',
  `message` text NOT NULL COMMENT 'Wallet 인증 메세지',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간'
);

CREATE TABLE `db_auth`.`tb_auth_project_linkage` (
  `project_id` varchar(255) COMMENT '프로젝트 ID',
  `account_key` varchar(255) COMMENT 'Account 연동 키',
  `link_key` varchar(255) COMMENT '하위 Provider 연동 키',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간',
  PRIMARY KEY (`project_id`, `account_key`, `link_key`)
);

CREATE TABLE `db_auth`.`tb_auth_social_personal_information` (
  `project_id` varchar(255) COMMENT '프로젝트 ID',
  `provider` varchar(255) COMMENT '제공자 ex)google',
  `social_id` varchar(255) COMMENT '소셜 유니크 ID',
  `email` varchar(255) NOT NULL COMMENT '소셜에 연동된 Email',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간',
  PRIMARY KEY (`project_id`, `provider`, `social_id`)
);

CREATE TABLE `db_auth`.`tb_auth_project_information` (
  `project_id` varchar(255) COMMENT '프로젝트 ID',
  `service_id` varchar(255) COMMENT '서비스 ID',
  `project_display_name` varchar(255) NOT NULL COMMENT '프로젝트 디스플레이명',
  `reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록 시간',
  PRIMARY KEY (`project_id`, `service_id`)
);

ALTER TABLE `db_auth`.`tb_auth_social` COMMENT = 'Social 맵핑 테이블';

ALTER TABLE `db_auth`.`tb_auth_wallet` COMMENT = 'Wallet 테이블';

ALTER TABLE `db_auth`.`tb_auth_passkey` COMMENT = 'Passkey 테이블';

ALTER TABLE `db_auth`.`tb_auth_guest` COMMENT = 'Guest 테이블';

ALTER TABLE `db_auth`.`tb_auth_account` COMMENT = '계정 테이블';

ALTER TABLE `db_auth`.`tb_auth_blacklist` COMMENT = '계정 블랙 리스트 등록 테이블';

ALTER TABLE `db_auth`.`tb_auth_email_verify_config` COMMENT = 'Email 검증 관련 설정 테이블';

ALTER TABLE `db_auth`.`tb_auth_oauth_config` COMMENT = 'Social 로그인을 위한 Oauth 2.0 설정 테이블';

ALTER TABLE `db_auth`.`tb_auth_wallet_signature_message_config` COMMENT = 'Wallet Signature 검증을 위한 메세지 설정 테이블';

ALTER TABLE `db_auth`.`tb_auth_project_linkage` COMMENT = 'Account와 하위 Provider를 프로젝트 단위로 맵핑하는 테이블';

ALTER TABLE `db_auth`.`tb_auth_social_personal_information` COMMENT = 'Social 로그인 계정 개인정보 저장 테이블';

ALTER TABLE `db_auth`.`tb_auth_project_information` COMMENT = '프로젝트 정보 테이블';

