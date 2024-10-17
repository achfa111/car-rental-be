/*
  Warnings:

  - You are about to drop the column `createdBy` on the `cars` table. All the data in the column will be lost.
  - You are about to drop the column `createdDt` on the `cars` table. All the data in the column will be lost.
  - You are about to drop the column `isAvailable` on the `cars` table. All the data in the column will be lost.
  - You are about to drop the column `isDriver` on the `cars` table. All the data in the column will be lost.
  - You are about to drop the column `licenseNumber` on the `cars` table. All the data in the column will be lost.
  - You are about to drop the column `updatedBy` on the `cars` table. All the data in the column will be lost.
  - You are about to drop the column `updatedDt` on the `cars` table. All the data in the column will be lost.
  - You are about to drop the column `createdBy` on the `roles` table. All the data in the column will be lost.
  - You are about to drop the column `createdDt` on the `roles` table. All the data in the column will be lost.
  - You are about to drop the column `updatedBy` on the `roles` table. All the data in the column will be lost.
  - You are about to drop the column `updatedDt` on the `roles` table. All the data in the column will be lost.
  - You are about to drop the column `createdBy` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `createdDt` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `role` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `updatedBy` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `updatedDt` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `featureAccess` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `menu` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `menuAccess` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `menuFeatures` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `order` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[role]` on the table `roles` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `role_id` to the `users` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "featureAccess" DROP CONSTRAINT "featureAccess_features_id_fkey";

-- DropForeignKey
ALTER TABLE "featureAccess" DROP CONSTRAINT "featureAccess_menu_access_id_fkey";

-- DropForeignKey
ALTER TABLE "menu" DROP CONSTRAINT "menu_menu_id_fkey";

-- DropForeignKey
ALTER TABLE "menuAccess" DROP CONSTRAINT "menuAccess_menu_id_fkey";

-- DropForeignKey
ALTER TABLE "menuAccess" DROP CONSTRAINT "menuAccess_role_id_fkey";

-- DropForeignKey
ALTER TABLE "menuFeatures" DROP CONSTRAINT "menuFeatures_menu_id_fkey";

-- DropForeignKey
ALTER TABLE "order" DROP CONSTRAINT "order_car_id_fkey";

-- DropForeignKey
ALTER TABLE "order" DROP CONSTRAINT "order_user_id_fkey";

-- DropIndex
DROP INDEX "car_name_index";

-- AlterTable
ALTER TABLE "cars" DROP COLUMN "createdBy",
DROP COLUMN "createdDt",
DROP COLUMN "isAvailable",
DROP COLUMN "isDriver",
DROP COLUMN "licenseNumber",
DROP COLUMN "updatedBy",
DROP COLUMN "updatedDt",
ADD COLUMN     "created_by" VARCHAR,
ADD COLUMN     "created_dt" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "is_available" BOOLEAN DEFAULT true,
ADD COLUMN     "is_driver" BOOLEAN,
ADD COLUMN     "license_number" VARCHAR(30),
ADD COLUMN     "updated_by" VARCHAR,
ADD COLUMN     "updated_dt" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "roles" DROP COLUMN "createdBy",
DROP COLUMN "createdDt",
DROP COLUMN "updatedBy",
DROP COLUMN "updatedDt",
ADD COLUMN     "created_by" VARCHAR,
ADD COLUMN     "created_dt" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "updated_by" VARCHAR,
ADD COLUMN     "updated_dt" TIMESTAMP(3);

-- AlterTable
ALTER TABLE "users" DROP COLUMN "createdBy",
DROP COLUMN "createdDt",
DROP COLUMN "role",
DROP COLUMN "updatedBy",
DROP COLUMN "updatedDt",
ADD COLUMN     "created_by" VARCHAR,
ADD COLUMN     "created_dt" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "role_id" INTEGER NOT NULL,
ADD COLUMN     "updated_by" VARCHAR,
ADD COLUMN     "updated_dt" TIMESTAMP(3),
ALTER COLUMN "birthdate" SET DATA TYPE VARCHAR;

-- DropTable
DROP TABLE "featureAccess";

-- DropTable
DROP TABLE "menu";

-- DropTable
DROP TABLE "menuAccess";

-- DropTable
DROP TABLE "menuFeatures";

-- DropTable
DROP TABLE "order";

-- CreateTable
CREATE TABLE "orders" (
    "id" SERIAL NOT NULL,
    "order_no" VARCHAR NOT NULL,
    "user_id" INTEGER NOT NULL,
    "car_id" INTEGER NOT NULL,
    "start_time" TIMESTAMP(6),
    "end_time" TIMESTAMP(6),
    "total" DOUBLE PRECISION,
    "is_driver" BOOLEAN,
    "is_expired" BOOLEAN,
    "status" VARCHAR,
    "created_dt" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_dt" TIMESTAMP(3),
    "created_by" VARCHAR,
    "updated_by" VARCHAR,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "test" (
    "id" INTEGER NOT NULL,

    CONSTRAINT "test_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "menus" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "icon" TEXT,
    "path" TEXT,
    "is_submenu" BOOLEAN NOT NULL DEFAULT false,
    "parent_id" INTEGER,
    "permissions" TEXT[],
    "created_dt" TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP,
    "updated_dt" TIMESTAMP(3),
    "created_by" VARCHAR,
    "updated_by" VARCHAR,

    CONSTRAINT "menus_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "access" (
    "id" SERIAL NOT NULL,
    "role_id" INTEGER NOT NULL,
    "menu_id" INTEGER NOT NULL,
    "visible" BOOLEAN NOT NULL DEFAULT true,
    "grant" JSONB NOT NULL,

    CONSTRAINT "access_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "orders_order_no_key" ON "orders"("order_no");

-- CreateIndex
CREATE UNIQUE INDEX "menus_name_key" ON "menus"("name");

-- CreateIndex
CREATE UNIQUE INDEX "roles_role_key" ON "roles"("role");

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_carId_fkey" FOREIGN KEY ("car_id") REFERENCES "cars"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_userId_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "menus" ADD CONSTRAINT "menus_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "menus"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "access" ADD CONSTRAINT "access_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "roles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "access" ADD CONSTRAINT "access_menu_id_fkey" FOREIGN KEY ("menu_id") REFERENCES "menus"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- RenameIndex
ALTER INDEX "users_phone_number_key" RENAME TO "users_phoneNumber_key";
