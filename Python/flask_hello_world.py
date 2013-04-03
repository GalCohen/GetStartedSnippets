from flask import Flask
app = Flask(__name__)

@app.route("/")
def hello():
	string = """
	<script>
	alert(\"hi\");
	</script>
	"""
	return "Hello World weepeee!"+string

if __name__ == "__main__":
    app.run(debug=True)