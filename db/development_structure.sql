CREATE TABLE "announcements" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "course_id" integer, "subject" varchar(255), "body" text, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "assignments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "description" text, "due_at" datetime, "course_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "courses" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "code" varchar(255), "user_id" integer, "begins_on" date, "ends_on" date, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "courses_users" ("course_id" integer, "user_id" integer);
CREATE TABLE "documents" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "description" varchar(255), "attachable_id" integer, "created_at" datetime, "updated_at" datetime, "attached_file_name" varchar(255), "attached_content_type" varchar(255), "attached_file_size" integer, "attached_updated_at" datetime, "attachable_type" varchar(255));
CREATE TABLE "links" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "course_id" integer, "name" varchar(255), "description" varchar(255), "url" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "submissions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "assignment_id" integer, "student_id" integer, "created_at" datetime, "updated_at" datetime, "upload_file_name" varchar(255), "upload_content_type" varchar(255), "upload_file_size" integer, "upload_updated_at" datetime);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(128) DEFAULT '' NOT NULL, "password_salt" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "remember_token" varchar(255), "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "confirmation_token" varchar(255), "confirmed_at" datetime, "confirmation_sent_at" datetime, "failed_attempts" integer DEFAULT 0, "unlock_token" varchar(255), "locked_at" datetime, "authentication_token" varchar(255), "created_at" datetime, "updated_at" datetime, "type" varchar(255), "name" varchar(255));
CREATE UNIQUE INDEX "index_users_on_confirmation_token" ON "users" ("confirmation_token");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "index_users_on_unlock_token" ON "users" ("unlock_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20100905071852');

INSERT INTO schema_migrations (version) VALUES ('20100901041354');

INSERT INTO schema_migrations (version) VALUES ('20100901052838');

INSERT INTO schema_migrations (version) VALUES ('20100901191933');

INSERT INTO schema_migrations (version) VALUES ('20100901192148');

INSERT INTO schema_migrations (version) VALUES ('20100902021009');

INSERT INTO schema_migrations (version) VALUES ('20100902041624');

INSERT INTO schema_migrations (version) VALUES ('20100902044856');

INSERT INTO schema_migrations (version) VALUES ('20100905021916');

INSERT INTO schema_migrations (version) VALUES ('20100906001939');

INSERT INTO schema_migrations (version) VALUES ('20100906024302');

INSERT INTO schema_migrations (version) VALUES ('20100906213016');

INSERT INTO schema_migrations (version) VALUES ('20100906215720');