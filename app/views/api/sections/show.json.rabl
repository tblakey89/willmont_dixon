object @section
attributes :id, :name, :order, :work_at_height, :scaffolder, :ground_worker, :operate_machinery, :lift_loads, :young, :supervisor
child(:videos) { attributes :id }
child(:questions) { attributes :id }
