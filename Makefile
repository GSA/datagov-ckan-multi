default: opencontrol fedramp-templates

 clean:
	rm -Rf _data/opencontrols/opencontrols/

 opencontrol:
	masonry get -d _data/

 fedramp-templates: opencontrol fedramp-tower fedramp-openshift fedramp-openstack fedramp-rhvh fedramp-rhvm

 fedramp-tower:
	cd _data/opencontrols && \
	compliance-masonry get -c opencontrol-ansible-tower.yaml && \
	cd - && \
	fedramp-templater fill _data/opencontrols/opencontrols/ files/fedramp/templates/FedRAMP-System-Security-Plan-Template-v2.1.docx files/fedramp/FedRAMP-System-Security-Plan-Ansible-Tower.docx && \
	rm -Rf _data/opencontrols/opencontrols/

 fedramp-openshift:
	cd _data/opencontrols && \
	compliance-masonry get -c opencontrol-openshift.yaml && \
	cd - && \
	fedramp-templater fill _data/opencontrols/opencontrols/ files/fedramp/templates/FedRAMP-System-Security-Plan-Template-v2.1.docx files/fedramp/FedRAMP-System-Security-Plan-RedHat-OpenShift-Container-Platform-3.docx && \
	rm -Rf _data/opencontrols/opencontrols/

 fedramp-openstack:
	cd _data/opencontrols && \
	compliance-masonry get -c opencontrol-openstack.yaml && \
	cd - && \
	fedramp-templater fill _data/opencontrols/opencontrols/ files/fedramp/templates/FedRAMP-System-Security-Plan-Template-v2.1.docx files/fedramp/FedRAMP-System-Security-Plan-OpenStack-Platform-13.docx && \
	rm -Rf _data/opencontrols/opencontrols/

 fedramp-rhvh:
	cd _data/opencontrols && \
	compliance-masonry get -c opencontrol-rhvh.yaml && \
	cd - && \
	fedramp-templater fill _data/opencontrols/opencontrols/ files/fedramp/templates/FedRAMP-System-Security-Plan-Template-v2.1.docx files/fedramp/FedRAMP-System-Security-Plan-RedHat-Virtualization-Host.docx && \
	rm -Rf _data/opencontrols/opencontrols/

 fedramp-rhvm:
	cd _data/opencontrols && \
	compliance-masonry get -c opencontrol-rhvm.yaml && \
	cd - && \
	fedramp-templater fill _data/opencontrols/opencontrols/ files/fedramp/templates/FedRAMP-System-Security-Plan-Template-v2.1.docx files/fedramp/FedRAMP-System-Security-Plan-RedHat-Virtualization-Manager.docx && \
	rm -Rf _data/opencontrols/opencontrols/