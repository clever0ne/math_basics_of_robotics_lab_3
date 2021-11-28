function data = load_data(filepath)
    id = fopen(filepath, 'r');
    data = fscanf(id, '%c');
    data = str2num(data);
    fclose(id);
end