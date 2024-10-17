-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_role_id_fkey";

-- AlterTable
ALTER TABLE "access" ADD COLUMN     "created_by" VARCHAR,
ADD COLUMN     "created_dt" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_by" VARCHAR,
ADD COLUMN     "updated_dt" TIMESTAMP(3);

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE CASCADE ON UPDATE CASCADE;
