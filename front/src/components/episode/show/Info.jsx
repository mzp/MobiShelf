import React from "react";
import PropTypes from "prop-types";
import {Link} from "react-router";
import b from "components/lib/b";
import Types from "components/prop-types";

export default class extends React.Component {
    static displayName = "Episode.Info"

    static propTypes = {
        "show": PropTypes.bool,
        ...Types.episode
    }

    static defaultProps = {"show": false}

    render () {
        const {
          author,
          "author_url": url,
          "magazine_title": magazineTitle,
          "magazine_url": magazineUrl,
          next,
          prev,
          show,
          title
        } = this.props;

        if (!show) {
            return null;
        }

        const layout = b.with("overlayLayout");

        return (
            <div className={layout()}>
                <div className={layout("main")}>{title}</div>
                <div className={layout("sub")}>
                    <Link to={url}>{author}</Link>
                </div>
                <div className={layout("sub")}>
                    <Link to={magazineUrl}>{magazineTitle}</Link>
                </div>
                <div className={layout("navigation")}>
                    { prev && <Link to={prev.url}>{"<<"}{prev.title}</Link>}
                    { next && <Link to={next.url}>{next.title}{">>"}</Link>}
                </div>
            </div>
        );
    }
}
