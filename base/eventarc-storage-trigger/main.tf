# # 1. מציאת נתונים על הפרויקט והחשבונות הקיימים
# data "google_project" "project" {
#     project_id = var.project_id
# }

# data "google_storage_project_service_account" "gcs_account" {
#     project = var.project_id
# }

# resource "google_project_iam_member" "eventarc_agent_binding" {
#     project = var.project_id
#     role    = "roles/eventarc.serviceAgent"
#     member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-eventarc.iam.gserviceaccount.com"

#     lifecycle {
#         prevent_destroy = true
#     }
# }

# resource "google_project_iam_member" "gcs_publisher_binding" {
#     project = var.project_id
#     role    = "roles/pubsub.publisher"
#     member  = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"

#     lifecycle {
#         prevent_destroy = true
#     }
# }

# resource "google_project_iam_member" "pubsub_token_creator" {
#     project = var.project_id
#     role    = "roles/iam.serviceAccountTokenCreator"
#     member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"

#     lifecycle {
#         prevent_destroy = true
#     }
# }


# 4. ה-Trigger עצמו
resource "google_eventarc_trigger" "storage_trigger" {
    name     = var.trigger_name
    project  = var.project_id
    location = var.region

    matching_criteria {
        attribute = "type"
        value     = "google.cloud.storage.object.v1.finalized"
    }

    matching_criteria {
        attribute = "bucket"
        value     = var.bucket_name
    }

    destination {
        cloud_run_service {
            service = var.cloud_run_service_name
            region  = var.region
        }
    }

    service_account = var.eventarc_service_account_email

    # חשוב: להגיד לטרפורם לחכות שההרשאות ייווצרו לפני שהוא מנסה ליצור את הטריגר
    # depends_on = [
    #     google_project_iam_member.eventarc_agent_binding,
    #     google_project_iam_member.gcs_publisher_binding,
    #     google_project_iam_member.pubsub_token_creator
    # ]
}
